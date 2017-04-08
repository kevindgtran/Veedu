//
//  ProductDetailsVC.swift
//  Veedu
//
//  Created by Prathiba Lingappan on 4/6/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import Firebase

class ProductDetailsVC: UIViewController {
    
    //MARK: properties
    var ref: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    var remoteConfig: FIRRemoteConfig!
    var keyboardOnScreen = false
    fileprivate var _refHandle: FIRDatabaseHandle!
    fileprivate var _authHandle: FIRAuthStateDidChangeListenerHandle!
    var user: FIRUser?

    var product: Product?
    var reviews = [Review]()
    
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //getReviews()
        
        productTableView.register(UINib(nibName: "ProductDetailsCell", bundle: nil), forCellReuseIdentifier: "cellOne")
        
        productTableView.register(UINib(nibName: "ReviewsCell", bundle: nil), forCellReuseIdentifier: "cellTwo")
    }
    
    func getReviews() {
        ref = FIRDatabase.database().reference()
        
        _refHandle = ref.child("allReviews").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            //A Product from Firebase
            let review = snapshot.value as! [String:Any]
            
            let title = review[Review.ReviewKeys.title] ?? "title"
            let content = review[Review.ReviewKeys.content] ?? "content"
            let rating = review[Review.ReviewKeys.rating] ?? "rating"
            
            //Creating Product Instance
            guard let titleInString = title as? String else {return}
            guard let contentInString = content as? String else {return}
            guard let ratingInString = rating as? Double else {return}
            
            //to cache the downloaded images
            let newReview = Review(titleInString, ratingInString, contentInString)
            self.reviews.append(newReview)
            
        }
    }

}

extension ProductDetailsVC: UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        <#code#>
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            guard let cell = productTableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath) as? ProductDetailsCell else { return UITableViewCell()}
            
            guard let product = product else {return UITableViewCell()}
            
            cell.productImage.image = product.productImage
            cell.productName.text = product.productName
            cell.productPrice.text = String(describing: product.productPrice)
            cell.productDescription.text = product.productDescription
            cell.productMeasurements.text = product.productMeasurements
            cell.productMaterial.text = product.productMaterial
            
            return cell
        }
        else {
            guard let cell = productTableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath) as? ReviewsCell else { return UITableViewCell()}
            
            cell.reviewTitle.text = reviews[indexPath.row - 1].title
            cell.reviewRating.text = String (reviews[indexPath.row - 1].rating) + "/5"
            cell.reviewContent.text = reviews[indexPath.row - 1].content
            
            return cell
        }        
    }
    
}


