//
//  FavoritesTableViewCell.swift
//  Veedu
//
//  Created by Kevin Tran on 4/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    //MARK: properties
    @IBOutlet weak var favoritesImageLabel: UIImageView!
    @IBOutlet weak var favoritesNameLabel: UILabel!
    @IBOutlet weak var favoritesPriceLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func addToCart(_ sender: Any) {
//        if let user = User.shared {
//            
//            //print("Inside IF in addToCartAction")
//            
//            guard let product = self.product else {return}
//            user.addToCart(product.productID)
//            
//            Firebase.shared.addToCartFirebase(product.productID)
//        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
