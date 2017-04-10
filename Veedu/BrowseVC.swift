//
//  BrowseVC.swift
//  Veedu
//
//  Created by Joy Umali on 4/7/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class BrowseVC: ButtonBarPagerTabStripViewController {
    
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
    
    var previousTab = UICollectionViewCell()
    
    let allSampleImages = [
        ["LivingFurniture", "LivingAccessories", "LivingLighting", "LivingThrows", "LivingPillows", "LivingRugs"],
        ["BedAccessories", "BedFurniture", "BedLighting", "BedTextiles"],
        ["Cookware", "DiningFurniture", "Diningware", "DiningBarware", "SmallAppliances"],
        ["BathAccessories", "BathTextiles"]
    ]
    
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
   
    override func viewDidLoad() {
        
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.purpleInspireColor
        }
        
        super.viewDidLoad()
        
        self.sampleImages = allSampleImages[0]
        
        
    }

    func viewControllers(for pagerTabStripController: UICollectionViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "JoyMain", bundle: nil).instantiateViewController(withIdentifier: "ProductCategoryCell")
//        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child2")
        return [child_1]
    }
    
    
    

    // MARK: DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        var cell: RoomTabCVCell
        
        if collectionView == self.roomTabCollectionView {
            guard let cell = roomTabCollectionView.dequeueReusableCell(withReuseIdentifier: "RoomTabCell", for: indexPath) as? RoomTabCVCell else {
                print("***Error creating RoomTabCell at \(indexPath.row).***")
                return UICollectionViewCell()
            }
            
            cell.roomTabLabel.text = sampleTabs[indexPath.row] //testing
            print(cell.roomTabLabel.text)
            //            cell.roomTabLabel.text = roomCategories[indexPath.row].roomName
            
            // 'highlight' on first active tab which is at index 0.
            // TODO: change to underline
            if indexPath.row == 0 {
                cell.layer.borderWidth = 2.0
                cell.layer.borderColor = UIColor.red.cgColor
                previousTab = cell // this removes the highlight on the previousTab
            }
            
            
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.roomTabCollectionView {
            sampleImages = allSampleImages[indexPath.row]
            productCategoryCollectionView.reloadData()
            
            
            //changing the border to indicate the tab selected
            let cell = collectionView.cellForItem(at: indexPath)
            
            previousTab.layer.borderWidth = 0
            
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor.red.cgColor
            
            previousTab = cell!
            
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
