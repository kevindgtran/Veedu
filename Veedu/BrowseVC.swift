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
    
    let sampleTabs = ["Living", "Bed", "Dining", "Bath"]
    var sampleImages = [String?]()
    
    let allSampleImages = [
        ["LivingFurniture", "LivingAccessories", "LivingLighting", "LivingThrows", "LivingPillows", "LivingRugs"],
        ["BedAccessories", "BedFurniture", "BedLighting", "BedTextiles"],
        ["Cookware", "DiningFurniture", "Diningware", "DiningBarware", "SmallAppliances"],
        ["BathAccessories", "BathTextiles"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        roomTabCollectionView.dataSource = self
//        roomTabCollectionView.delegate = self
//        roomTabCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "RoomTabCell")
//        
//        productCategoryCollectionView.dataSource = self
//        productCategoryCollectionView.delegate = self
//        productCategoryCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ProductCategoryCell")
        self.sampleImages = allSampleImages[0]

    }
}



extension BrowseVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count: Int?
        
        if collectionView == self.roomTabCollectionView {
            count = sampleTabs.count // test
//            count = roomCategories.count
            print("**Number of Room Tabs: \(String(describing: count))")
        }
        
        if collectionView == self.productCategoryCollectionView {
//            count = roomProductCategories.count
            count = sampleImages.count //testing
            print("**Number of product categories: \(String(describing: count))") // add name of room in print statement
        }
        
        return count!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        var cell: RoomTabCVCell
        
        if collectionView == self.roomTabCollectionView {
            guard let cell = roomTabCollectionView.dequeueReusableCell(withReuseIdentifier: "RoomTabCell", for: indexPath) as? RoomTabCVCell else {
                print("***Error creating RoomTabCell at \(indexPath.row).***")
                return UICollectionViewCell()
            }
            
            cell.roomTabLabel.text = sampleTabs[indexPath.row] //testing
            print(cell.roomTabLabel.text)
//            cell.roomTabLabel.text = roomCategories[indexPath.row].roomName

            return cell
        }
        
        if collectionView == self.productCategoryCollectionView {
            guard let cell = productCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCategoryCell", for: indexPath) as? ProductCategoryCVCell else {
                print("***Error creating ProductCategoryCell.***")
                return UICollectionViewCell()
            }
            
            if let prodCategoryImage = self.sampleImages[indexPath.row] {
                cell.prodCategoryImage.image = UIImage(named: prodCategoryImage)
            } else {
                print("***Error retrieving image from assets.***")
            }
                cell.prodCategoryLabel.text = sampleImages[indexPath.row]
            print(cell.prodCategoryLabel.text)

//                cell.prodCategoryLabel.text = roomProductCategories[indexPath.row].productCategoryName
            return cell

        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.roomTabCollectionView {
        sampleImages = allSampleImages[indexPath.row]
            productCategoryCollectionView.reloadData()
        
        }
        
        
//        if collectionView == self.productCategoryCollectionView {
//            
//            
//            
//        }
//    }
    
}
}

// MARK: Delegate

//extension BrowseVC: UICollectionViewDelegate {

    //    // Delegate from Selected Product Category to Product List
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
    
    
//}
