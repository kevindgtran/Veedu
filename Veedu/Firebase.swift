//
//  Authentication.swift
//  Veedu
//
//  Created by Prathiba Lingappan on 4/11/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuthUI

class Firebase {
    
    //MARK: properties
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    var storageRef: FIRStorageReference!
    var remoteConfig: FIRRemoteConfig!
    var keyboardOnScreen = false
    fileprivate var _refHandle: FIRDatabaseHandle!
    
    //setup firebase authentication variables
    fileprivate var _authHandle: FIRAuthStateDidChangeListenerHandle!
    var user: FIRUser?
    
    static let shared = Firebase()
    
    //create configure authentication function
    func configureAuth() {
        
        print("Inside configureAuth")
        
        _authHandle = FIRAuth.auth()?.addStateDidChangeListener { (auth: FIRAuth, user: FIRUser?) in
            //check if current user matches the FIRUser
            if let activeUser = user {
                
                print("Inside FIRST IF in configureAuth")
                
                //User.configure(username: (user?.email)!)
                
                if self.user != activeUser {
                    
                    print("Inside SECOND IF in configureAuth")
                    
                    self.user = activeUser
                    User.configure(username: (user?.email)!)
                    //let name = user!.email!.components(separatedBy: "@")[0]
                    //self.displayName = name
                }
            }
            else {
                print("Inside ELSE in configureAuth")
                self.loginSession()
            }
        }
        
    }
    
    //present login session
    func loginSession() {
        
        var topController = UIApplication.shared.keyWindow?.rootViewController
        
        while let controller = topController?.presentedViewController {
            topController = controller
        }
        
        print("In loginSession")
        
        let authViewController = FUIAuth.defaultAuthUI()!.authViewController()
        topController?.present(authViewController, animated: true, completion: nil)
    }
    
    // MARK: Send Message
    
    func addToCartFirebase(data: [String:[Product]]) {
        
        //create method that pushes message to the firebase database
        
        //ref = FIRDatabase.database().reference()
        guard let username = User.shared?.username.components(separatedBy: "@")[0] else {return}
        print("username: \(username)")
        print("inCart: \(data["inCart"]?[0].productName)")
        ref.child("data").child("2").child(username).childByAutoId().setValue(data)
    }
    
    func getReviews(_ product: Product, _ completion: @escaping([Review]?) -> Void) {
        //ref = FIRDatabase.database().reference()
        
        _refHandle = ref.child("data").child("1").child("allReviews").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            //A Review from Firebase
            let review = snapshot.value as! [String:Any]
            
            let newProductID = review[Review.ReviewKeys.productID] ?? "[productID]"
            
            guard let productIDInString = newProductID as? String else {return}
            let productID = product.productID
            
            if productIDInString ==  productID{
                let title = review[Review.ReviewKeys.title] ?? "[title]"
                let content = review[Review.ReviewKeys.content] ?? "[review]"
                let rating = review[Review.ReviewKeys.rating] ?? "[rating]"
                
                //Creating Review Instance
                guard let titleInString = title as? String else {return}
                guard let contentInString = content as? String else {return}
                guard let ratingInDouble = rating as? Double else {return}
                
                //to cache the reviews
                let newReview = Review(productIDInString, titleInString, ratingInDouble, contentInString)
                var reviews: [Review] = []
                reviews.append(newReview)
                completion(reviews)
                
            }
        }
    }
    
    func getCartItemsFromFirebase() {
        //code
    }
    
    func getFavoritesFromFirebase() {
        
        //code
    }
    
    func configureStorage() {
        storageRef = FIRStorage.storage().reference()
    }
    
    deinit {
        ref.child("data").removeObserver(withHandle: _refHandle)
        //ref.child("data").child("1").child("allReviews").removeObserver(withHandle: _refHandle)
    }
    
  
    
    
    
    //////////////////////// Fetch Products ////////////////////////////
    
    
    
    
    func  getProducts(_ storyCategory: String?, _ roomCategory: String?, _ productCategory: String?) {
        
        //ref = FIRDatabase.database().reference()
        
        //var products: [Product]
        
        _refHandle = ref.child("data").child("0").child("allProducts").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            
            //A Product from Firebase
            let product = snapshot.value as! [String:Any]
            
            if storyCategory == nil {
                self.filterBasedOnRoomCategory(product, roomCategory, productCategory)
            }
            else {
                self.filterBasedOnStoryCategory(product, storyCategory)
            }
        }
    }
    
    func filterBasedOnStoryCategory(_ product: [String: Any], _ storyCategory: String?) {
        
        guard let storyCategoryInString = getStoryCategory(product) else {return}
        guard let storyCategory = storyCategory else {return}
        
        if storyCategoryInString == storyCategory {
            getProductDetails(product)
        }
        
    }
    
    func filterBasedOnRoomCategory(_ product: [String: Any], _ roomCategory: String?, _ productCategory: String?) {
        
        // print("In filterBasedOnRoomCategory")
        
        guard let roomCategoryInString = getRoomCategory(product) else {return}
        guard let roomCategory = roomCategory else {
            print("guard - Error with room cagegory")
            return
        }
        
        //print("Success with room category")
        
        for room in roomCategoryInString {
            
            // print("Inside room for loop")
            
            if room == roomCategory {
                
                //print("Inside if for room category")
                
                guard let productCategoryInString = getProductCategory(product) else {return}
                guard let productCategory = productCategory else {
                    print("guard - Error with product category")
                    return
                }
                
                //print("Success with product category")
                
                if productCategoryInString[0] == productCategory {
                    // print("Inside if for product category")
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
        
        //print("In getProductDetails")
        
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
        
        var products: [Product] = []
        products.append(newProduct)
        //print("added product to array")
        
        //self.productCollectionView.insertItems(at: [IndexPath(row: self.products.count - 1, section: 0)])
        
    }


}
