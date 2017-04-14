//
//  InventoryVC.swift
//  Veedu
//
//  Created by Joy Umali on 4/11/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import Firebase

class InventoryVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var inventoryTableView: UITableView!
    
    //MARK: properties
    var ref: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    var remoteConfig: FIRRemoteConfig!
    var keyboardOnScreen = false
    fileprivate var _refHandle: FIRDatabaseHandle!
    fileprivate var _authHandle: FIRAuthStateDidChangeListenerHandle!
    var user: FIRUser?
    
    // MARK: UNCOMMENT BELOW WHEN FIREBASE DATA COMPLETE
    var products = [Product]()
    //    var productsTest = ["*A Mighty Fine Chair*", "*ID6479gh51*", "*Mid-Century Modern*"]
    //    var prodCategoryTest = [
    //        ["*Furniture*", "*Lighting*", "*Textiles*", "*Accessories*"],
    //        ["*", "b", "c", "d"],
    //        ["9", "8", "7", "6"],
    //        ["cat", "dog", "frog", "fish"]
    //    ]
    //    var roomCategoryTest = [
    //        ["*Kitchen & Dining*", "*Livingroom*", "*Bedroom*", "*Bathroom*"],
    //        ["*Kitchen & Dining*", "*Livingroom*", "*Bedroom*", "*Bathroom*"],
    //        ["*Kitchen & Dining*", "*Livingroom*", "*Bedroom*", "*Bathroom*"],
    //        ["*Kitchen & Dining*", "*Livingroom*", "*Bedroom*", "*Bathroom*"]
    //        ]
    
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("In View Did Load")
        
        configureDatabase()
        configureStorage()
                print(products.count)
        
    }
    
    func configureDatabase() {
        
        ref = FIRDatabase.database().reference()
        
        _refHandle = ref.child("data").child("allProducts").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            
            //A Product from Firebase
            let product = snapshot.value as! [String:Any]
            
            self.getProductDetails(product)
            
        }
    }
    
    func getStoryCategory(_ product: [String: Any]) -> String? {
        
        let newStoryCategory = product[Product.ProductKeys.storyCategory] ?? "[storyCategory]"
        guard let storyCategoryInString = newStoryCategory as? String else {return nil}
        
        return storyCategoryInString
    }
    
    func getRoomCategory(_ product: [String: Any]) -> [String]? {
        
        let newRoomCategory = product[Product.ProductKeys.roomCategory] ?? "[roomCategory]"
        guard let roomCategoryInString = newRoomCategory as? [String] else {return nil}
        
        return roomCategoryInString
    }
    
    func getProductCategory(_ product: [String: Any]) -> [String]? {
        
        let newProductCategory = product[Product.ProductKeys.productCategory] ?? "[productCategory]"
        guard let productCategoryInString = newProductCategory as? [String] else {return nil}
        
        return productCategoryInString
    }
    
    func getProductDetails(_ product: [String: Any]) {
        
        print("In getProductDetails")
        
        let productID = product[Product.ProductKeys.productID] ?? "productID"
        let name = product[Product.ProductKeys.name] ?? "[name]"
        let price = product[Product.ProductKeys.price] ?? "[price]"
        let imageURL = product[Product.ProductKeys.imageURL] ?? "[imageURL]"
        let description = product[Product.ProductKeys.description] ?? "[description]"
        let measurements = product[Product.ProductKeys.measurements] ?? "[specifications]"
        let reviews = product[Product.ProductKeys.productReviews] ?? "[reviews]"
        
        //Creating Product Instance
        guard let productIDAsString = productID as? String else {return}
        guard let nameInString = name as? String else {return}
        guard let priceInDouble = price as? Double else {return}
        guard let imageURLInString = imageURL as? String else {return}
        guard let descriptionInString = description as? String else {return}
        guard let measurementsInStringArray = measurements as? [String] else {return}
        let reviewsInStringArray = reviews as? [String]
        
        guard let roomCategory = getRoomCategory(product) else {return}
        guard let productCategory = getProductCategory(product) else {return}
        guard let storyCategory = getStoryCategory(product) else {return}
        
        //to cache the downloaded images
        let newProduct = Product(productIDAsString, nameInString, priceInDouble, imageURLInString, descriptionInString, measurementsInStringArray, reviewsInStringArray, storyCategory, roomCategory, productCategory )
        
        // MARK: UNCOMMENT BELOW WHEN FIREBASE DATA COMPLETE
        self.products.append(newProduct)
        print("added product to array")
        
        self.inventoryTableView.insertRows(at: [IndexPath(row: self.products.count - 1, section: 0)], with: .automatic)
        
    }
    
    func configureStorage() {
        storageRef = FIRStorage.storage().reference()
    }
    
    deinit {
        ref.child("data").child("0").child("allProducts").removeObserver(withHandle: _refHandle)
    }
    
    // MARK: IBActions
    @IBAction func addButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "ToAddProductSegue", sender: self)
    }
    
}


extension InventoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(products.count)
        return products.count
        //        return productsTest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = inventoryTableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath) as? InventoryTVCell else {
            print("***Error creating Inventory Product Cell.***")
            return UITableViewCell()
        }
        
        // MARK: UNCOMMENT BELOW WHEN FIREBASE DATA COMPLETE
        
        if let productImage = self.products[indexPath.row].productImage {
            cell.productInventoryImage.image = productImage
        }
        else{
            Product.downloadImage(products[indexPath.row].productImageURL) { (image) in
                self.products[indexPath.row].productImage = image
                DispatchQueue.main.async {
                    cell.productInventoryImage.image = self.products[indexPath.row].productImage
                }
            }
        }
        
        cell.productName.text = products[indexPath.row].productName
        print(products[indexPath.row].productName)
        cell.productID.text = products[indexPath.row].productID
        cell.storyName.text = products[indexPath.row].storyCategory         // this gives lowercase.
        cell.roomCategory.text = (products[indexPath.row].roomCategory)[0] // selects the first room in the roomCategory array
        if (products[indexPath.row].roomCategory).count > 1{
        cell.roomCategoryIndex1.text = (products[indexPath.row].roomCategory)[1]
        }
//        cell.roomCategoryIndex2.text = (products[indexPath.row].roomCategory)[2]
//        cell.roomCategoryIndex3.text = (products[indexPath.row].roomCategory)[3]
        cell.productCategory.text = (products[indexPath.row].productCategory)[0] // Even though this is set up as an array, there is only one json value per product.
        
        //        // Testing while firebase under construction
        //        cell.productName.text = productsTest[0]
        //        cell.productID.text = productsTest[1]
        //        cell.storyName.text = productsTest[2]        // this gives lowercase.
        //        cell.roomCategory.text = (roomCategoryTest[0])[0] // selects the first room in the roomCategory array
        //        cell.roomCategoryIndex1.text = (roomCategoryTest[0])[1]
        //        cell.roomCategoryIndex2.text = (roomCategoryTest[0])[2]
        //        cell.roomCategoryIndex3.text = (roomCategoryTest[0])[3]
        //        cell.productCategory.text = (prodCategoryTest[0])[0] // Even though this is set up as an array, there is only one json value per product.
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            products.remove(at: indexPath.row)
            //            productsTest.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}


// MARK: Complete delegate from InventoryVC(Vendor) to ProductDetailsVC(Prathiba)

extension InventoryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        let storyboard = UIStoryboard(name: "KevinMain", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "productDetailsVC") as? ProductDetailsVC else { return }
        
        if let selectedIndexPath = selectedIndexPath {
            // going to one product detail view
            viewController.product = self.products[selectedIndexPath.row]
            
            present(viewController, animated: true, completion: nil)
        }
    }
}
















