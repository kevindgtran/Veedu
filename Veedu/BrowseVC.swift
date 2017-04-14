
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
    
    //    // instances for Browse Search.  should hold all products and filter through the properties.
    //    var browseKeywords = [Product]()
    //    var resultSearchController: UISearchController!
    //    var PRODUCTS = [Product]()
    //
    //    // Create search bar and placement
    //    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 50, 0)
    //    self.resultSearchController = UISearchController(searchResultsController: nil)
    //    self.resultSearchController.searchResultsUpdater = self
    //    self.resultSearchController.dimsBackgroundDuringPresentation = false
    //    self.resultSearchController.searchBar.sizeToFit()
    //    self.tableView.tableHeaderView = self.resultSearchController.searchBar
    //    self.tableView.reloadData()
    
    // Instance for Room Tab Collection View
    let textForTabs = RoomCategory.rooms
    
    // Instance for Main Collection View
    var productCategories = [ProductCategory]()
    
    // Temp instance for active tab cell.
    var previousTab = IndexPath(row: 0, section: 0)
    
    // CollectionDelegateFlowLayout constants
    let columns: CGFloat = 2.0
    var inset: CGFloat = 8.0
    var spacing: CGFloat = 4.0
    var lineSpacing: CGFloat = 8.0
    
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
            
            
            // Signify first active tab is the first one.
            if indexPath == previousTab {
                cell.select()
            }
            return cell
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
            
            previousTab = indexPath

            productCategoryCollectionView.reloadData()
            roomTabCollectionView.reloadData()
            // Active Cell is underlined and darker grey
                // the new cell style changes
                // previousTab changes too. deselect
                // the new cell then becomes the value of previousTab
 

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
extension BrowseVC: UICollectionViewDelegateFlowLayout {
    
    /*    CollectionDelegateFlowLayout constants
    let columns: CGFloat = 2.0
    let inset: CGFloat = 8.0
    let spacing: CGFloat = 4.0
    let lineSpacing: CGFloat = 8.0
    */
    
    // assign these functions only to the productCategoryCollectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Int((collectionView.frame.width / columns) -  (inset + spacing))
        let width2 = 150
        var size = CGSize(width: width, height: width)
        if collectionView == self.productCategoryCollectionView {
            
            size = CGSize(width: width, height: width)
        } else {
            size = CGSize(width: width2, height: width/3)
            
        }
        
        return size
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

