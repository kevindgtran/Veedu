//
//  InventoryTVCell.swift
//  Veedu
//
//  Created by Joy Umali on 4/11/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class InventoryTVCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var productName: UILabel!

    @IBOutlet weak var productID: UILabel!

    @IBOutlet weak var roomCategory: UILabel! // pulls index0
    
    @IBOutlet weak var roomCategoryIndex1: UILabel!
    
    @IBOutlet weak var roomCategoryIndex2: UILabel!
    
    @IBOutlet weak var roomCategoryIndex3: UILabel!
    
    @IBOutlet weak var storyName: UILabel!
    
    @IBOutlet weak var productCategory: UILabel! // this is an array with just one
    
    @IBOutlet weak var productInventoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
