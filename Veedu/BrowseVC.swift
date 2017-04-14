//
//  BrowseVC.swift
//  Veedu
//
//  Created by Joy Umali on 4/7/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class BrowseVC: UIViewController { //, UISearchResultsUpdating {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var roomTabCollectionView: UICollectionView!
    @IBOutlet weak var productCategoryCollectionView: UICollectionView!
    
    var selectedIndexPath: IndexPath?
    var selectedIndexPathTwo: IndexPath?
    
    // Instance for Room Tab Collection View
    let textForTabs = RoomCategory.rooms
    
    // Instance for Main Collection View
    var productCategories = [ProductCategory]()
    
    // Temp instance for active tab cell.
    var previousTab = ActiveCellCVC()
    
    // CollectionDelegateFlowLayout constants
    let columns: CGFloat = 2.0
    let inset: CGFloat = 8.0
    let spacing: CGFloat = 4.0
    let lineSpacing: CGFloat = 8.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productCategories = ProductCategory.livingRoomProdCategories
        selectedIndexPathTwo = IndexPath(row: 0, section: 0)
    }

}


// MARK: DataSource
extension BrowseVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //var count: Int
        
        if collectionView == self.roomTabCollectionView {
            //print("**Number of Room Tabs: \(String(describing: count))")
            return textForTabs.count
            
        }
        else {
            return productCategories.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // DataSource for Browse Tab Bar (Labels for Rooms)
        if collectionView == self.roomTabCollectionView {
            guard let cell = roomTabCollectionView.dequeueReusableCell(withReuseIdentifier: "RoomTabCell", for: indexPath) as? RoomTabCVCell else {
                print("***Error creating RoomTabCell at \(indexPath.row).***")
                return UICollectionViewCell()
            }
            cell.roomTabLabel.text = textForTabs[indexPath.row].roomName
            print(cell.roomTabLabel.text!)
            
//            if cell.isSelected {
//                cell.roomTabLabel.textColor = UIColor.red
//            } else {
//                // change color back to whatever it was
//                cell.roomTabLabel.textColor = UIColor.black
//            }
//            
//            if indexPath.row == 0 {
//                cell.roomTabLabel.textColor = UIColor.red
//                previousTab = cell
//            }
            // Signify first active tab is the first one.
            if indexPath.row == 0 {
                cell.selectedMenuBarItem()
                previousTab = cell // this removes the highlight on the previousTab
            }
            return UICollectionViewCell()
        }
    
    
        // DataSource for Product Categories Per Room (Images and Labels)
        if collectionView == self.productCategoryCollectionView {
            guard let cell = productCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCategoryCell", for: indexPath) as? ProductCategoryCVCell else {
                print("***Error creating ProductCategoryCell.***")
                return UICollectionViewCell()
            }
            
            let prodCategoryImage = self.productCategories[indexPath.row].productCategoryImage
            cell.prodCategoryImage.image = UIImage(named: prodCategoryImage)

            
            cell.prodCategoryLabel.text = productCategories[indexPath.row].productCategoryName
            print(cell.prodCategoryLabel.text!)
            
            return cell
            
        }
        return UICollectionViewCell()
    }
}
// MARK: Delegates
extension BrowseVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
         let cell = tableView.cellForRowAtIndexPath(indexPath) as! MPSurveyTableViewCell
         
         // change color back to whatever it was
         cell.customLabel.textColor = UIColor.blackColor()
         tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
         */
        
        if collectionView == self.roomTabCollectionView {
            selectedIndexPathTwo = indexPath
        
            switch indexPath.row {
            case 0:
                productCategories = ProductCategory.livingRoomProdCategories
            case 1:
                productCategories = ProductCategory.bedroomProdCategories
            case 2:
                productCategories = ProductCategory.kitchenDiningProdCategories
            case 3:
                productCategories = ProductCategory.bathroomProdCategories
            default:
                print("Error selecting array of product categories depending on room selected.")
            }
            
            productCategoryCollectionView.reloadData()
            
            // Active Cell is underlined and darker grey
            let cell = collectionView.cellForItem(at: indexPath) as! RoomTabCVCell
//            // change color back to whatever it was
//            cell.roomTabLabel.textColor = UIColor.black
//            collectionView.reloadItems(at: [indexPath])
            
            //([indexPath], withRowAnimation: UITableViewRowAnimation.None)
            
            
            if previousTab != cell {
            // a different room is being selected, style change to selected room
                previousTab.didDeselectCell()
              cell.selectedMenuBarItem()
//                cell.roomTabLabel.textColor = UIColor.red
                previousTab = cell
            } else {
                // same room selected right after so state does not change.
                
            }
            
            
//            cell.selectedMenuBarItem()
//            if previousTab == cell {
//                cell.selectedMenuBarItem()
//            } else {
//            previousTab.didDeselectCell()
//            }
            previousTab = cell
        }
        
        // MARK: Connect Joy & Prathiba Storyboards. From Browse to ProductsPerCategory.
        if collectionView == self.productCategoryCollectionView {
            selectedIndexPath = indexPath
            
            performSegue(withIdentifier: "BrowseToProductList", sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProductsPerCategoryVC {
            if let selectedIndexPath = selectedIndexPath, let selectedIndexPathTwo = selectedIndexPathTwo {
                destination.roomCategory = self.textForTabs[selectedIndexPathTwo.row].firebaseName
                //print("destination.roomCategory: \(destination.roomCategory)")
                destination.productCategory = self.productCategories[selectedIndexPath.row].firebaseCategoryName
                //print("destination.productCategory: \(destination.productCategory)")
            }
        }
    }
}


//// MARK: DelegateFlowLayout for ProductCategoriesPerRoom
//extension BrowseVC: UICollectionViewDelegateFlowLayout {
//    
//    // assign these functions only to the productCategoryCollectionView
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
////        if collectionView == self.roomTabCollectionView {
//
//        let width = Int((productCategoryCollectionView.frame.width / columns) -  (inset + spacing))
//            return CGSize(width: width, height: width)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return spacing
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return lineSpacing
//    }
//}

