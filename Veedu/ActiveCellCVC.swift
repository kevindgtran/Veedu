//
//  UnderlinedCellCVC.swift
//  Veedu
//
//  Created by Joy Umali on 4/10/17.
//  Copyright © 2017 com.example. All rights reserved.
//

// ***Used to Browse Scene, Room Category Tab***

import UIKit

class ActiveCellCVC: UICollectionViewCell {
    
    // put in underlined function with the ishidden
    
    //need property that keeps track of the border. then ishidden...
    
    
    
    func underlined(){
        
        let border = CALayer()
        let width = CGFloat(3.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
//        border.isHidden = false
    }
    
    func didDeselectCell(){
        
        let border = CALayer()
        let width = CGFloat(3)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
    
    func darkenLabel() {
        
        
    }
}

