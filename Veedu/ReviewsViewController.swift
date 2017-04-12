//
//  ReviewsViewController.swift
//  Veedu
//
//  Created by Prathiba Lingappan on 4/10/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var productName: UILabel!
    
    var product: Product?
    var reviews = [Review]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let product = product else {return}
        
        productName.text = product.productName
        
        Firebase.shared.getReviews(product){ (reviews) in
            guard let tempReviews = reviews else {return}
            self.reviews = tempReviews
            self.reviewTableView.reloadData()
            
            //print("sources list count: \(self.sourcesArray.count)")

            //self.reviewTableView.beginUpdates()
            //self.reviewTableView.insertRows(at: [IndexPath(row: self.reviews.count - 1, section: 0)], with: UITableViewRowAnimation.automatic)
            //self.reviewTableView.endUpdates()
        }

        Firebase.shared.configureStorage()
        
        reviewTableView.register(UINib(nibName: "ReviewsCell", bundle: nil), forCellReuseIdentifier: "cellTwo")
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

