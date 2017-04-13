//
//  ProductCollectionViewCell.swift
//  Veedu
//
//  Created by Prathiba Lingappan on 4/6/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    //IBOutlets
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    //IBActions
    @IBAction func addFavorite(_ sender: Any) {
//        Firebase.shared.configureAuth({
//            if let user = User.shared {
//                guard let product = self.product else {return}
//                user.addToFavorite(product.productID)
//                
//                Firebase.shared.addToFavoritesFirebase(product.productID)
//            }
//        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImage.image = nil
    }
}
