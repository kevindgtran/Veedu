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
    var productsFromFirebase: [FIRDataSnapshot]! = []
    var storageRef: FIRStorageReference!
    var remoteConfig: FIRRemoteConfig!
    var keyboardOnScreen = false
    fileprivate var _refHandle: FIRDatabaseHandle!
    fileprivate var _authHandle: FIRAuthStateDidChangeListenerHandle!
    var user: FIRUser?
    
    var products =  [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatabase()
        configureStorage()
        //self.signedInStatus(isSignedIn: true)
    }
    
    //not used
    func signedInStatus(isSignedIn: Bool) {
        
        if (isSignedIn) {
            
        }
    }
    
    func  configureDatabase() {
        
        ref = FIRDatabase.database().reference()
        
        _refHandle = ref.child("allProducts").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            self.productsFromFirebase.append(snapshot)
            self.productCollectionView.insertItems(at: [IndexPath(row: self.productsFromFirebase.count - 1, section: 0)])
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsFromFirebase.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else {
            print("Error creating Product cell")
            return UICollectionViewCell()
        }
        
        //Product from Firebase
        let productSnapshot: FIRDataSnapshot! = productsFromFirebase[indexPath.row]
        let product = productSnapshot.value as! [String:Any]
        let name = product[Product.ProductKeys.name] ?? "[name]"
        let price = product[Product.ProductKeys.price] ?? "[price]"
        let imageURL = product[Product.ProductKeys.imageURL] ?? "[imageURL]"

        //Displaying on Collection view
        Product.downloadImage((imageURL as? String)!) { (image) in
            if self.productCollectionView.indexPathsForVisibleItems.contains(indexPath) == true {
                //self.articlesListArray[indexPath.row].image = image
                DispatchQueue.main.async {
                    cell.productImage.image = image
                }
            }
        }
        cell.productName.text = name as? String
        guard let priceInString = price as? Double else {return UICollectionViewCell()}
        cell.productPrice.text = String(describing: priceInString)

        
        return cell
    }
}
