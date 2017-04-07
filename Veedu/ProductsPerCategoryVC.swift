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
    //var productsFromFirebase: [FIRDataSnapshot]! = []
    var storageRef: FIRStorageReference!
    var remoteConfig: FIRRemoteConfig!
    var keyboardOnScreen = false
    fileprivate var _refHandle: FIRDatabaseHandle!
    fileprivate var _authHandle: FIRAuthStateDidChangeListenerHandle!
    var user: FIRUser?
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collection view constraints
        let width = productCollectionView!.frame.width / 2
        //let layout = collectionViewLayout as! UICollectionViewLayout
        
        configureDatabase()
        configureStorage()
    }
    
    func  configureDatabase() {
        
        ref = FIRDatabase.database().reference()
        
        _refHandle = ref.child("allProducts").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            //A Product from Firebase
            let product = snapshot.value as! [String:Any]
            let name = product[Product.ProductKeys.name] ?? "[name]"
            let price = product[Product.ProductKeys.price] ?? "[price]"
            let imageURL = product[Product.ProductKeys.imageURL] ?? "[imageURL]"
            
            //Creating Product Instance
            guard let nameInString = name as? String else {return}
            guard let priceInString = price as? Double else {return}
            guard let imageURLInString = imageURL as? String else {return}
            
            //to cache the downloaded images
            let newProduct = Product(nameInString, priceInString, imageURLInString)
            self.products.append(newProduct)
            
            self.productCollectionView.insertItems(at: [IndexPath(row: self.products.count - 1, section: 0)])
        }
    }
    
    func configureStorage() {
        storageRef = FIRStorage.storage().reference()
    }
    
    deinit {
        ref.child("allProducts").removeObserver(withHandle: _refHandle)
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
