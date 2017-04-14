//
//  RoomTabCVCell.swift
//  Veedu
//
//  Created by Joy Umali on 4/7/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class RoomTabCVCell: ActiveCellCVC {
    
    @IBOutlet weak var roomTabLabel: UILabel!
    private var customLayer: CALayer?
    
    
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        
//        roomTabLabel.text = nil
//    }
    
    func select() {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 25, width: frame.width, height: 2)
        layer.backgroundColor = UIColor.red.cgColor
        roomTabLabel.layer.addSublayer(layer)
        customLayer = layer
    }
    
    func deselect() {
        customLayer?.removeFromSuperlayer()
        customLayer = nil
    }
}
