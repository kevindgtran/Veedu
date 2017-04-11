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
    
    var selectedIndexPath: IndexPath?
    
    // Instance of array of products with the selected 'room tag' && 'product category'
    // TO DO:
    
    // Instance for Room Tab Collection View
    let textForTabs = RoomCategory.rooms
    
    // Instance for Main Collection View
    var productCategories = [ProductCategory?]()
    
    // Temp instance for active tab cell.
    var previousTab = ActiveCellCVC()
    
    // CollectionDelegateFlowLayout constants
    let columns: CGFloat = 2.0
    let inset: CGFloat = 8.0
    let spacing: CGFloat = 4.0
    let lineSpacing: CGFloat = 8.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        createSearchBar()
        self.productCategories = ProductCategory.livingRoomProdCategories
    }
    
//    func createSearchBar() {
//        let searchBar = UISearchBar()
//        searchBar.showsCancelButton = false
//        searchBar.placeholder = "Enter search here..."
//        searchBar.delegate = self as! UISearchBarDelegate
//        self.navigationItem.titleView = searchBar
//    }
}

// MARK: DataSource
extension BrowseVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count: Int?
        
        if collectionView == self.roomTabCollectionView {
            count = textForTabs.count
            print("**Number of Room Tabs: \(String(describing: count))")
        }
        
        if collectionView == self.productCategoryCollectionView {
            count = productCategories.count
            print("**Number of product categories: \(String(describing: count))") // add name of room in print statement
        }
        
        return count!
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
            
            // Signify first active tab is the first one.
            if indexPath.row == 0 {
                cell.underlined()
                previousTab = cell // this removes the highlight on the previousTab
            }
            return cell
        }
        
        // DataSource for Product Categories Per Room (Images and Labels)
        if collectionView == self.productCategoryCollectionView {
            guard let cell = productCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCategoryCell", for: indexPath) as? ProductCategoryCVCell else {
                print("***Error creating ProductCategoryCell.***")
                return UICollectionViewCell()
            }
            
            if let prodCategoryImage = self.productCategories[indexPath.row]?.productCategoryImage {
                cell.prodCategoryImage.image = UIImage(named: prodCategoryImage)
            } else {
                print("***Error retrieving image from assets.***")
            }
            
            cell.prodCategoryLabel.text = productCategories[indexPath.row]?.productCategoryName
            print(cell.prodCategoryLabel.text!)
            
            return cell
            
        }
        return UICollectionViewCell()
    }
}

// MARK: Delegates
extension BrowseVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.roomTabCollectionView {
            
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
            let cell = collectionView.cellForItem(at: indexPath) as! ActiveCellCVC
            cell.underlined()
            previousTab.didDeselectCell()
            previousTab = cell
        }
        
        // MARK: Segue from Browse to ProductsPerCategory
        if collectionView == self.productCategoryCollectionView {
            selectedIndexPath = indexPath
            
            performSegue(withIdentifier: "ToProductList", sender: self)
        }
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        <#code#>
    //    }
    
}


//// MARK: DelegateFlowLayout for ProductCategoriesPerRoom
extension BrowseVC: UICollectionViewDelegateFlowLayout {
    
    // assign these functions only to the productCategoryCollectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        if collectionView == self.roomTabCollectionView {

        let width = Int((productCategoryCollectionView.frame.width / columns) -  (inset + spacing))
            return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
}






// MARK: Delegate
//
//extension BrowseVC: UICollectionViewDelegate {
//
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
//
//
//}
