//
//  ReviewsViewController.swift
//  Veedu
//
//  Created by Prathiba Lingappan on 4/10/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import Firebase

class ReviewsViewController: UIViewController {

    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var productName: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let product = product else {return}
        
        productName.text = product.productName
        
        getReviews()
        configureStorage()
        
        reviewTableView.register(UINib(nibName: "ReviewsCell", bundle: nil), forCellReuseIdentifier: "cellTwo")
    }

    func getReviews() {
        ref = FIRDatabase.database().reference()
        
        _refHandle = ref.child("data").child("1").child("allReviews").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            //A Review from Firebase
            let review = snapshot.value as! [String:Any]
            
            let newProductID = review[Review.ReviewKeys.productID] ?? "[productID]"
            
            guard let productIDInString = newProductID as? String else {return}
            guard let productID = self.product?.productID else {return}
            
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
                self.reviews.append(newReview)
                
                self.reviewTableView.beginUpdates()
                self.reviewTableView.insertRows(at: [IndexPath(row: self.reviews.count - 1, section: 0)], with: UITableViewRowAnimation.automatic)
                self.reviewTableView.endUpdates()
            }            
            
        }
        
    }
    
    func configureStorage() {
        storageRef = FIRStorage.storage().reference()
    }
    
    deinit {
        ref.child("data").child("1").child("allReviews").removeObserver(withHandle: _refHandle)
    }

}

extension ReviewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath) as? ReviewsCell else { return UITableViewCell()}
        
        cell.reviewTitle.text = reviews[indexPath.row].title
        cell.reviewRating.text = String (reviews[indexPath.row].rating) + "/5"
        cell.reviewContent.text = reviews[indexPath.row].content
        
        return cell
        
    }
    
}

