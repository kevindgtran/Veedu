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
    
    var products = [Product]()
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDatabase()
        configureStorage()
    }
    
    func  configureDatabase() {
        
        ref = FIRDatabase.database().reference()
        
        _refHandle = ref.child("data").child("0").child("allProducts").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            
            //A Product from Firebase
            //print(snapshot.value)
            let product = snapshot.value as! [String:Any]
            
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
            
            //to cache the downloaded images
            let newProduct = Product(productIDAsString, nameInString, priceInDouble, imageURLInString, descriptionInString, measurementsInStringArray, reviewsInStringArray)
            self.products.append(newProduct)
            
            self.productCollectionView.insertItems(at: [IndexPath(row: self.products.count - 1, section: 0)])
            
        }
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
