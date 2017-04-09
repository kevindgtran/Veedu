//
//  BrowseVC.swift
//  Veedu
//
//  Created by Joy Umali on 4/7/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class BrowseVC: UIViewController {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var roomTabCollectionView: UICollectionView!
    @IBOutlet weak var productCategoryCollectionView: UICollectionView!
    
    // Instance array for Room Category Tab Label
    let roomCategories = [RoomCategory]()
    
    // Instance array for Product Category Images & Labels
    // create variable
    let roomProductCategories = [ProductCategory]()
    
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomTabCollectionView.dataSource = self
        roomTabCollectionView.delegate = self
        roomTabCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "RoomTabCell")
        
        productCategoryCollectionView.delegate = self
        productCategoryCollectionView.delegate = self
        productCategoryCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ProductCategoryCell")
        
    }
    
}


extension BrowseVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count: Int?
        
        if collectionView == self.roomTabCollectionView {
            count = roomCategories.count
        }
        
        if collectionView == self.productCategoryCollectionView {
            count = roomProductCategories.count
        }
        
        //        return roomCategories.count
        return count!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell?
        
        if collectionView == self.roomTabCollectionView {
            guard let cell = roomTabCollectionView.dequeueReusableCell(withReuseIdentifier: "RoomTabCell", for: indexPath) as? RoomTabCVCell else {
                print("***Error creating RoomTabCell.***")
                return UICollectionViewCell()
            }
            cell.roomTabLabel.text = "tabTESTING"
            //        cell.roomTabLabel.text = roomCategories[indexPath.row].roomName
            
        }
        
        
/*        if let storyImage = self.storyCategories[indexPath.row].storyImage {
            cell.storyImage.image = UIImage(named: storyImage)
        } else {
            print("***Error retrieving image from assets.***")
        }
        
  */
        
        
        
        
        
        
        
        
        if collectionView == self.productCategoryCollectionView {
            guard let cell = productCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCategoryCell", for: indexPath) as? ProductCategoryCVCell else {
                print("***Error creating ProductCategoryCVCell.***")
                return UICollectionViewCell()
            }
            cell.prodCategoryLabel.text = "TESTING"
            cell.prodCategoryImage.image = "TESTING"

            //        cell.roomTabLabel.text = roomCategories[indexPath.row].roomName
            
        }
        
        return cell!
        
    }
    
    //    // MARK: Delegate from Selected Product Category to Product List
    //    // To link to Prathiba's ProductsPerCategory Scene
    //    // to create data source for ProductCategoryCollectionView
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        print("***Product Category Selected: \(roomCategories[indexPath.row].productCategory)***")
    //        selectedIndexPath = indexPath
    //
    //        // Segue name may change.
    //        performSegue(withIdentifier: "ToProductPerCategoryList", sender: self)
    //    }
    //
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        print("***Preparing to Segue to \(roomCategories[indexPath.row].productCategory)***")
    //
    //        if let destination = segue.destination as? ProductsPerCategoryVC {
    //            if let selectedIndexPath = selectedIndexPath {
    //                destination. =
    //            }
    //        }
    //    }
    
    
}
