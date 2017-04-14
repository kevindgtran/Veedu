//
//  MenuBar.swift
//  Veedu
//
//  Created by Joy Umali on 4/13/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

//
//  MenuBar.swift
//  youtube
//
//  Created by Brian Voong on 6/6/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegateFlowLayout {
    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = UIColor.rgb(230, green: 32, blue: 31)
//        cv.dataSource = self
//        cv.delegate = self
//        return cv
//    }()
//    
    let cellId = "cellId"
//    let imageNames = ["home", "trending", "subscriptions", "account"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        
//        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
//        
//        addSubview(collectionView)
//        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
//        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
//        
//        let selectedIndexPath = IndexPath(item: 0, section: 0)
//        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())
        
        // For white slide bar
        setupHorizontalBar()
    }
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    // For white slide bar
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.black
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
    
        
        //laying out our views. where should the bar be placed
        //need x, y, width, height constraints
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.item)
//        let x = CGFloat(indexPath.item) * frame.width / 4
//        horizontalBarLeftAnchorConstraint?.constant = x
//        
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
////        
////        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
////        cell.tintColor = UIColor.rgb(91, green: 14, blue: 13)
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: frame.width / 4, height: frame.height)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//
//class MenuCell: BaseCell {
//    
//    let imageView: UIImageView = {
//        let iv = UIImageView()
//        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
//        iv.tintColor = UIColor.rgb(91, green: 14, blue: 13)
//        return iv
//    }()
//    
//    override var isHighlighted: Bool {
//        didSet {
//            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(91, green: 14, blue: 13)
//        }
//    }
//    
//    override var isSelected: Bool {
//        didSet {
//            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(91, green: 14, blue: 13)
//        }
//    }
//    
//    override func setupViews() {
//        super.setupViews()
//        
//        addSubview(imageView)
//        addConstraintsWithFormat("H:[v0(28)]", views: imageView)
//        addConstraintsWithFormat("V:[v0(28)]", views: imageView)
//        
//        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
//    }
//    
//}
//








