//
//  ProductsPerCategoryVC.swift
//  Veedu
//
//  Created by Prathiba Lingappan on 4/6/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import Firebase

class ProductsPerCategoryVC: UIViewController {

    @IBOutlet weak var productCollectionView: UICollectionView!
    
    //MARK: properties
    var ref: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    var remoteConfig: FIRRemoteConfig!
    var keyboardOnScreen = false
    fileprivate var _refHandle: FIRDatabaseHandle!
    fileprivate var _authHandle: FIRAuthStateDidChangeListenerHandle!
    var user: FIRUser?
    
    var roomCategory: String?
    var productCategory: String?
    var storyCategory: String?

    var products = [Product]()
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.roomCategory = "livingRoom"
        self.productCategory = "furniture"
        
        configureDatabase()
        configureStorage()
    }
    
    func  configureDatabase() {
        
        ref = FIRDatabase.database().reference()
        
        _refHandle = ref.child("data").child("0").child("allProducts").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            
            //A Product from Firebase
            let product = snapshot.value as! [String:Any]
            
            if self.storyCategory == nil {
                self.filterBasedOnRoomCategory(product)
            }
            else {
                self.filterBasedOnStoryCategory(product)
            }
        }
    }
    
    func filterBasedOnStoryCategory(_ product: [String: Any]) {
        
        guard let storyCategoryInString = getStoryCategory(product) else {return}
        guard let storyCategory = self.storyCategory else {return}
       
        if storyCategoryInString == storyCategory {
            getProductDetails(product)
        }

    }
    
    func filterBasedOnRoomCategory(_ product: [String: Any]) {
        
        guard let roomCategoryInString = getRoomCategory(product) else {return}
        guard let roomCategory = self.roomCategory else {return}
        
        for room in roomCategoryInString {
            if room == roomCategory {
                
                guard let productCategoryInString = getProductCategory(product) else {return}
                guard let productCategory = self.productCategory else {return}
                
                if productCategoryInString[0] == productCategory {
                    getProductDetails(product)
                }
                
                break
            }
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
        self.products.append(newProduct)
        
        self.productCollectionView.insertItems(at: [IndexPath(row: self.products.count - 1, section: 0)])
        
    }
    
    func configureStorage() {
        storageRef = FIRStorage.storage().reference()
    }
    
    deinit {
        ref.child("data").child("0").child("allProducts").removeObserver(withHandle: _refHandle)
    }
    
}

extension ProductsPerCategoryVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else {
            print("Error creating Product cell")
            return UICollectionViewCell()
        }
        
        //Displaying on Collection view
        if let productImage = self.products[indexPath.row].productImage {
            cell.productImage.image = productImage
        }
        else{
            Product.downloadImage(products[indexPath.row].productImageURL) { (image) in
                self.products[indexPath.row].productImage = image
                DispatchQueue.main.async {
                    cell.productImage.image = self.products[indexPath.row].productImage
                }                
            }
        }
        
        cell.productName.text = products[indexPath.row].productName
        cell.productPrice.text = String(products[indexPath.row].productPrice)
        
        return cell
    }
}

extension ProductsPerCategoryVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        performSegue(withIdentifier: "ToProductDetails", sender: "self")

    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProductDetailsVC {
            if let selectedIndexPath = selectedIndexPath {
                destination.product = products[selectedIndexPath.row]
            }
        }
    }
}
