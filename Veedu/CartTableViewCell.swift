//
//  CartTableViewCell.swift
//  Veedu
//
//  Created by Kevin Tran on 4/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    //MARK: properties
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var cartTitleLabel: UILabel!
    @IBOutlet weak var cartPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
