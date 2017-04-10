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

    // Instance for Room Tab Collection View
    let textForTabs = RoomCategory.rooms
    
    // Instances for Main Collection View
    var productCategories = [ProductCategory?]()
    let livingRoomProdCategories = ProductCategory.livingRoomProdCategories
    let bedroomProdCategories = ProductCategory.bedroomProdCategories
    let kitchenDiningProdCategories = ProductCategory.kitchenDiningProdCategories
    let bathroomProdCategories = ProductCategory.bathroomProdCategories
    
    // Temp instance for active tab cell.
    var previousTab = UICollectionViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productCategories = ProductCategory.livingRoomProdCategories
        
    }
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
            cell.roomTabLabel.text = textForTabs[indexPath.row].roomName //testing
            print(cell.roomTabLabel.text!)
            //            cell.roomTabLabel.text = roomCategories[indexPath.row].roomName
            
            // 'highlight' on first active tab which is at index 0.
            // TODO: change to underline
            if indexPath.row == 0 {
                
                //                cell.underlined()
                //                cell.layer.borderWidth = 2.0
                //                cell.layer.borderColor = UIColor.red.cgColor
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
            
            // depending on index path, choose method from ProductCategory
            //            var selectedRoom: String
            //            switch selectedRoom {
            //            case (indexPath.row == 0):
            //            selectedRoom = ProductCategory.livingRoomProdCategories,
            //
            //            }
            
            
            cell.prodCategoryLabel.text = productCategories[indexPath.row]?.productCategoryName
            print(cell.prodCategoryLabel.text)
            
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
                productCategories = livingRoomProdCategories
            case 1:
                productCategories = bedroomProdCategories
            case 2:
                productCategories = kitchenDiningProdCategories
            case 3:
                productCategories = bathroomProdCategories
            default:
                print("Error selecting array of product categories depending on room selected.")
            }

            productCategoryCollectionView.reloadData()

        
    }
}
}
// MARK: DelegateFlowLayout for ProductCategoriesPerRoom
//extension BrowseVC: UICollectionViewDelegateFlowLayout {
//}


// MARK: Underline for Tab Bar
// insert in its own View Class?

//subclass the label. border.ishidden = true
//extension UILabel {
//
//    override func underlined(){
//        let border = CALayer()
//        let width = CGFloat(3.0)
//        border.borderColor = UIColor.red.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
//        border.borderWidth = width
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
////        border.isHidden = true
//    }
//
//    override func removeUnderlined(){
//        _ = CALayer()
//        _ = CGFloat(0)
//
//    }
//}



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
