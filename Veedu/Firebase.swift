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

extension UIApplication {
    var topViewController: UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        
        while let controller = topController?.presentedViewController {
            topController = controller
        }
        return topController
    }
}

class Firebase: NSObject {
    
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
    func configureAuth(_ completion: @escaping() -> Void) {
        
        //print("Inside configureAuth")
        
        _authHandle = FIRAuth.auth()?.addStateDidChangeListener { (auth: FIRAuth, user: FIRUser?) in
            //check if current user matches the FIRUser
            if let activeUser = user {
                
                //print("Inside FIRST IF in configureAuth")
                
                //User.configure(username: (user?.email)!)
                
//                if self.user != activeUser {
//                    
//                    //print("Inside SECOND IF in configureAuth")
//                    
//                    //let name = user!.email!.components(separatedBy: "@")[0]
//                    //self.displayName = name
//                } else {
//                    
//                }

                self.user = activeUser
                User.configure(username: (user?.email)!)
                
                completion()
            }
            else {
                print("Inside ELSE in configureAuth")
                self.loginSession()
            }
        }
    }
    
    func showProfileDetailsView() {
        let storyboard = UIStoryboard(name: "KevinMain", bundle: nil)
        let profileDetail = storyboard.instantiateViewController(withIdentifier: "ProfileDetailsVC")
        let topController = UIApplication.shared.topViewController
        
        topController?.present(profileDetail, animated: true, completion: nil)
    }
    
    //present login session
    func loginSession() {
        
        let topController = UIApplication.shared.topViewController
        
        print("In loginSession")
        
        let authViewController = FUIAuth.defaultAuthUI()!.authViewController()
        FUIAuth.defaultAuthUI()?.delegate = self
        topController?.present(authViewController, animated: true, completion: nil)
    }
    
    // MARK: Send Message
    
    func addUserToFirebase(data: [String:Any]) {
        
        self.ref.child("data").child("allUsers").child(data[User.UserKeys.username] as! String).setValue(data)
    }
    
    func getUserFromFirebase(_ completion: @escaping() -> Void) {
        
        guard let currentUser = User.shared else {return}
        let currentUsername = currentUser.username.components(separatedBy: "@")[0]
     
        _refHandle = ref.child("data").child("allUsers").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            //A User from Firebase
            let user = snapshot.value as! [String:Any]
            
            let username = user[User.UserKeys.username] ?? "[userName]"
            guard let usernameInString = username as? String else {return}
            //let newUsername = usernameInString.components(separatedBy: "@")[0]
            
            print("newUsername: \(usernameInString)")
            print("currentUsername: \(currentUsername)")
            
            if usernameInString == currentUsername{
                let firstName = user[User.UserKeys.firstName] ?? "[firstName]"
                let lastName = user[User.UserKeys.lastName] ?? "[lastName]"
                let billing = user[User.UserKeys.billing] ?? "[billing]"
                let shipping = user[User.UserKeys.shipping] ?? "[shipping]"
                let inCart = user[User.UserKeys.inCart] ?? "[inCart]"
                let favorite = user[User.UserKeys.favorite] ?? "[favorite]"
//                let orderHistory = user[User.UserKeys.orderHistory] ?? "[orderHistory]"
                
                //Creating User Instance
                guard let firstNameInString = firstName as? String else {return}
                guard let lastNameInString = lastName as? String else {return}
                guard let billingInString = billing as? String else {return}
                guard let shippingInString = shipping as? String else {return}
                guard let inCartInString = inCart as? [String] else {return}
                guard let favoriteInString = favorite as? [String] else {return}
//                guard let orderHistoryInString = orderHistory as? [String] else {return}
                
                //to cache the user
                currentUser.firstName = firstNameInString
                currentUser.lastName = lastNameInString
                currentUser.billing = billingInString
                currentUser.shipping = shippingInString
                currentUser.inCart = inCartInString
                currentUser.favorite = favoriteInString
                //currentUser.orderHistory = orderHistoryInString
                
                completion()
            }
        }

    }
    
    func removeFromCartFirebase(_ productID: String) {
        
        //create method that pushes message to the firebase database
        
        //ref = FIRDatabase.database().reference()
        guard let username = User.shared?.username.components(separatedBy: "@")[0] else {return}
        
        //print("username: \(username)")
        //print("inCart: \(data["inCart"]?[0])")
        
        ref.child("data").child("allUsers").child(username).observeSingleEvent(of: .value, with: { (snapshot) in
            var itemsInCart: [String] = []
            
            if snapshot.hasChild(User.UserKeys.inCart), let items = (snapshot.value as? [String: Any])?[User.UserKeys.inCart] as? [String] {
                itemsInCart = items
            }
            
            print("Firebase - itemsInCart: \(itemsInCart)")
            self.ref.child("data").child("allUsers").child(username).child(User.UserKeys.inCart).removeValue()
            
            //setValue(itemsInCart + [productID])
        })
    }
    
    func addToCartFirebase(_ productID: String) {
        
        //create method that pushes message to the firebase database
        
        //ref = FIRDatabase.database().reference()
        guard let username = User.shared?.username.components(separatedBy: "@")[0] else {return}
        
        //print("username: \(username)")
        //print("inCart: \(data["inCart"]?[0])")
        
        ref.child("data").child("allUsers").child(username).observeSingleEvent(of: .value, with: { (snapshot) in
            var itemsInCart: [String] = []
            
            if snapshot.hasChild(User.UserKeys.inCart), let items = (snapshot.value as? [String: Any])?[User.UserKeys.inCart] as? [String] {
                itemsInCart = items
            }
            
            print("Firebase - itemsInCart: \(itemsInCart)")
            self.ref.child("data").child("allUsers").child(username).child(User.UserKeys.inCart).setValue(itemsInCart + [productID])
        })
    }
    
    func addToFavoritesFirebase(_ productID: String) {
        
        //create method that pushes message to the firebase database
        
        //ref = FIRDatabase.database().reference()
        guard let username = User.shared?.username.components(separatedBy: "@")[0] else {return}
        
        //print("username: \(username)")
        //print("inCart: \(data["inCart"]?[0])")
        
        ref.child("data").child("allUsers").child(username).observeSingleEvent(of: .value, with: { (snapshot) in
            var itemsInCart: [String] = []
            
            if snapshot.hasChild(User.UserKeys.favorite), let items = (snapshot.value as? [String: Any])?[User.UserKeys.favorite] as? [String] {
                itemsInCart = items
            }
            
            print("Firebase - itemsInCart: \(itemsInCart)")
            self.ref.child("data").child("allUsers").child(username).child(User.UserKeys.favorite).setValue(itemsInCart + [productID])
        })
        
        //ref.child("data").child("allUsers").child(username).childByAutoId().setValue(data)
    }
    
    func getReviews(_ product: Product, _ completion: @escaping([Review]?) -> Void) {
        //ref = FIRDatabase.database().reference()
        
        _refHandle = ref.child("data").child("allReviews").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
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
    
    func getCartItemsFromFirebase(_ products: [String], _ completion: @escaping([Product]?) -> Void ) {
        
        print("Firebase - products: \(products)")
        
        var cartProducts: [Product] = []
        
        _refHandle = ref.child("data").child("allProducts").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            
            //A Product from Firebase
            let product = snapshot.value as! [String:Any]
            
            let productID = product[Product.ProductKeys.productID] ?? "productID"
            guard let productIDAsString = productID as? String else {return}
            
            for i in products {
                if i == productIDAsString {
                    
                    print("product in cart: \(i)")
                    
                    let name = product[Product.ProductKeys.name] ?? "[name]"
                    let price = product[Product.ProductKeys.price] ?? "[price]"
                    let imageURL = product[Product.ProductKeys.imageURL] ?? "[imageURL]"
                    let description = product[Product.ProductKeys.description] ?? "[description]"
                    let measurements = product[Product.ProductKeys.measurements] ?? "[specifications]"
                    let reviews = product[Product.ProductKeys.productReviews] ?? "[reviews]"
                    let newStoryCategory = product[Product.ProductKeys.storyCategory] ?? "[storyCategory]"
                    let newRoomCategory = product[Product.ProductKeys.roomCategory] ?? "[roomCategory]"
                    let newProductCategory = product[Product.ProductKeys.productCategory] ?? "[productCategory]"
                    
                    guard let nameInString = name as? String else {return}
                    guard let priceInDouble = price as? Double else {return}
                    guard let imageURLInString = imageURL as? String else {return}
                    guard let descriptionInString = description as? String else {return}
                    guard let measurementsInStringArray = measurements as? [String] else {return}
                    let reviewsInStringArray = reviews as? [String]
                    guard let storyCategoryInString = newStoryCategory as? String else {return}
                    guard let roomCategoryInString = newRoomCategory as? [String] else {return}
                    guard let productCategoryInString = newProductCategory as? [String] else {return}
                    
                    //to cache the downloaded products
                    let newProduct = Product(productIDAsString, nameInString, priceInDouble, imageURLInString, descriptionInString, measurementsInStringArray, reviewsInStringArray, storyCategoryInString, roomCategoryInString, productCategoryInString )
                    
                    cartProducts.append(newProduct)
                }
            }
            completion(cartProducts)
        }
    }
    
    func configureStorage() {
        storageRef = FIRStorage.storage().reference()
    }
    
    deinit {
        ref.child("data").removeObserver(withHandle: _refHandle)
        //ref.child("data").child("allReviews").removeObserver(withHandle: _refHandle)
    }
    
  
    
    
    
    //////////////////////// Fetch Products ////////////////////////////
    
    
    
    
    func  getProducts(_ storyCategory: String?, _ roomCategory: String?, _ productCategory: String?) {
        
        //ref = FIRDatabase.database().reference()
        
        //var products: [Product]
        
        _refHandle = ref.child("data").child("allProducts").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            
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

extension Firebase: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        showProfileDetailsView()
    }
}
