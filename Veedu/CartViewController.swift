//
//  CartViewController.swift
//  Veedu
//
//  Created by Kevin Tran on 4/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import CoreData

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //var CartProductNameArray: [NSManagedObject] = []
    
    var products: [String]?
    var cartProducts: [Product]?
    var selectedIndexPath: IndexPath?
    
    //MARK: properties
    @IBOutlet weak var cartItemCountLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var emptyBagImageView: UIImageView!
    
    //checkout area
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var greyBackGround: UIView!
    @IBOutlet weak var dollarSignLabel: UILabel!
    @IBOutlet weak var subtotalTextLabel: UILabel!
    @IBOutlet weak var checkoutButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Firebase.shared.configureStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Firebase.shared.configureAuth(controller: self) { authorized in
            if authorized {
                if let user = User.shared {
                    if let firstName = user.firstName {
                        self.products = user.inCart
                    }
                    else {
                        Firebase.shared.getUserFromFirebase {
                            
                            self.products = user.inCart
                            guard let productIds = self.products else {return}
                            
                            Firebase.shared.getCartItemsFromFirebase(productIds){ (products) in
                                guard let tempProducts = products else {return}
                                self.cartProducts = tempProducts
                                if let temp = self.products {
                                    self.cartItemCountLabel.text = String(describing: temp.count)
                                }
                                
                                self.cartTableView.reloadData()
                            }
                        }
                    }
                }
            }
            else {
                self.userNotLogedInAlert()
            }
            

        }
        
        //        if let _ = self.products {
        //            self.cartTableView.reloadData()
        //        }
        
        //fetch the data from the NSManagedObject and populate when the page appears
        //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        //            return
        //        }
        //
        //        let managedContext = appDelegate.persistentContainer.viewContext
        //
        //        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CartProduct")
        //        do {
        //            //create fetch request from NSManagedObject and store objects directly into array
        //            CartProductNameArray = try managedContext.fetch(fetchRequest)
        //        } catch let error as NSError {
        //            print("Could not fetch data")
        //        }
        //
        //        //update total items counter
        //        if CartProductNameArray.count > 0 {
        //            self.cartItemCountLabel.text = "\(self.CartProductNameArray.count)"
        //            subtotalLabel.isHidden = false
        //            greyBackGround.isHidden = false
        //            dollarSignLabel.isHidden = false
        //            subtotalTextLabel.isHidden = false
        //            checkoutButtonLabel.isHidden = false
        //        } else {
        //            self.cartItemCountLabel.text = "0"
        //            cartTableView.isHidden = true
        //            emptyBagImageView.isHidden = false
        //            subtotalLabel.isHidden = true
        //            greyBackGround.isHidden = true
        //            dollarSignLabel.isHidden = true
        //            subtotalTextLabel.isHidden = true
        //            checkoutButtonLabel.isHidden = true
        //        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let products = self.cartProducts {
            //print("String Product Count in Cart: \(self.products?.count)")
           // print("Product Count in Cart: \(products.count)")
            return products.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        
        //update the table with the Product
        guard let product = self.cartProducts?[indexPath.row] else {return UITableViewCell()}
        
        cell.cartTitleLabel?.text = product.productName
        cell.cartPriceLabel.text = String(product.productPrice)
        
        if let productImage = product.productImage {
            cell.cartImage.image  = productImage
        }
        else{
            Product.downloadImage(product.productImageURL) { (image) in
                product.productImage = image
                DispatchQueue.main.async {
                    cell.cartImage.image  = product.productImage
                }
            }
        }
        
        return cell
        
    }
    
    //swipe to delete and custom color
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let remove = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
            guard var cartProducts = self.cartProducts else {return}
            
            let productId = cartProducts[indexPath.row].productID
            guard let user = User.shared else {return}
            user.removeFromCart(productId)
            
            cartProducts.remove(at: indexPath.row)
            self.cartTableView.reloadData()
        }
        remove.backgroundColor = UIColor(red:0.91, green:0.29, blue:0.24, alpha:1.0)
        return[remove]
    }
    
    //save function
    func save(name: String) {
        //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        //            return
        //        }
        //
        //        let managedContext = appDelegate.persistentContainer.viewContext
        //
        //        let entity = NSEntityDescription.entity(forEntityName: "CartProduct", in: managedContext)!
        //
        //        let newProductName = NSManagedObject(entity: entity, insertInto: managedContext)
        //
        //        //set the new product name to the NSManagedObject
        //        newProductName.setValue(name, forKeyPath: "name")
        //
        //        //save new product to our NSManagedObjects and add to our array
        //        do {
        //            try managedContext.save()
        //            CartProductNameArray.append(newProductName)
        //        } catch let error as NSError {
        //            print("Could not save product name to array")
        //        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        performSegue(withIdentifier: "CartToProductDetails", sender: self)
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProductDetailsVC {
            if let selectedIndexPath = selectedIndexPath {
                guard let products = self.cartProducts else {return}
                destination.product = products[selectedIndexPath.row]
            }
        }
    }
    
    //MARK: actions
    @IBAction func checkoutButton(_ sender: UIButton) {
        
    }
    
    @IBAction func tempAddButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Item", message: "Add a new item", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let nameTextField = alert.textFields?.first,
                let nameToSave = nameTextField.text else {
                    return
            }
            
            self.save(name: nameToSave)
            self.cartTableView.isHidden = false
            self.emptyBagImageView.isHidden = true
            self.cartTableView.reloadData()
            guard let cartProducts = self.cartProducts else {return}
            self.cartItemCountLabel.text = "\(cartProducts.count)"
            
            //update the checkout section after adding new cart item
            self.subtotalLabel.isHidden = false
            self.greyBackGround.isHidden = false
            self.dollarSignLabel.isHidden = false
            self.subtotalTextLabel.isHidden = false
            self.checkoutButtonLabel.isHidden = false
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.textFields?[0].placeholder = "Title"
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

/*
 Setup Core Data - persist data upon loading
 1. import core data (app delegate & view controllers)
 2. (in app delegate)
 add persist container variable
 3. create data model and attributes
 4. (in view controller)
 create empty array of type NSManagedObject
 create save function, setvalue function, save/ print error, reload table
 create view will appear function - create fetch, data populate, refresh data
 5. (in view controller)
 create add function for button action to save
 */
