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
    
    var CartProductNameArray: [NSManagedObject] = []
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        return CartProductNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        
        //update the table with the newly created NSManaged item
        let someStuff: NSManagedObject = CartProductNameArray[indexPath.row]
        cell.cartTitleLabel?.text = someStuff.value(forKeyPath: "name") as? String
        
        return cell
    }
    
    //swipe to delete and custom color
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let remove = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
            self.CartProductNameArray.remove(at: indexPath.row)
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
            self.cartItemCountLabel.text = "\(self.CartProductNameArray.count)"
            
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
