//
//  ProductDetailsVC.swift
//  Veedu
//
//  Created by Prathiba Lingappan on 4/6/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productMeasurements: UILabel!
    @IBOutlet weak var productMaterial: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        guard let product = product else {return}
        
        productImage.image = product.productImage
        productName.text = product.productName
        productPrice.text = String(describing: product.productPrice)
        productDescription.text = product.productDescription
        productMeasurements.text = product.productSpecifications[0]
        productMaterial.text = product.productSpecifications[1]
        
    }
    
    @IBAction func addToCartAction(_ sender: Any) {
        
        Firebase.shared.configureAuth({
            
            //print("In addToCartAction ")
            
            if let user = User.shared {
                
                //print("Inside IF in addToCartAction")
                
                guard let product = self.product else {return}
                user.addToCart(product.productID)
                
                Firebase.shared.addToCartFirebase(product.productID)
            }
            
        })
        
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        
        Firebase.shared.configureAuth({
            if let user = User.shared {
                guard let product = self.product else {return}
                user.addToFavorite(product.productID)
                
                Firebase.shared.addToFavoritesFirebase(product.productID)
            }
        })
    }
    
    @IBAction func reviews(_ sender: Any) {
        
        performSegue(withIdentifier: "ToReviews", sender: "self")

    }
    
    //not used
    func alertForLogin() {
        
        let alert = UIAlertController(title: "Hello!", message: "Please login to continue!", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Got it!", style: .default)
        alert.addAction(saveAction)
        
        present(alert, animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ReviewsViewController {
            destination.product = product
        }
    }

    
}



