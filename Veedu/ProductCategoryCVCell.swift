//
//  ProductCategoryCVCell.swift
//  Veedu
//
//  Created by Joy Umali on 4/8/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ProductCategoryCVCell: UICollectionViewCell {
    
    @IBOutlet weak var prodCategoryImage: UIImageView!
    
    @IBOutlet weak var prodCategoryLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        prodCategoryImage.image = nil
        prodCategoryLabel.text = nil
    
    }
    
}
