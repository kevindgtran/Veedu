//
//  AddToInventoryVC.swift
//  Veedu
//
//  Created by Joy Umali on 4/11/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class AddToInventoryVC: UIViewController {
    
    // MARK: IBOutlets
    // TableView Controllers
    @IBOutlet weak var storyTableView: UITableView!
    @IBOutlet weak var roomTableView: UITableView!
    @IBOutlet weak var prodCategoryTableView: UITableView!
    
    @IBOutlet weak var addedProductName: UITextField!
    @IBOutlet weak var addedDescription: UITextView!
    @IBOutlet weak var addedSpecOne: UITextField!
    @IBOutlet weak var addedSpecTwo: UITextField!
    @IBOutlet weak var addedPrice: UITextField!
    @IBOutlet weak var addedImage: UIImageView!
    
    var addedItems = [Product]()
    var addedStory: Set<String> = []
    var addedRoom: Set<String> = []
    var addedProductCategories: Set<String> = []
    
    var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // empty/reload textfields & switches
    }
    
    // Save Button
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        //TODO: when tapped, all data added in the textfields and the imageView will be added to the firebase
        
        let newProdName = addedProductName.text
        let newProdDescription = addedDescription.text
        let newProdSpecOne = addedSpecOne.text
        let newProdSpecTwo = addedSpecTwo.text
        var newProdSpecs = [String]()
        newProdSpecs.append(newProdSpecOne!)
        if addedSpecTwo != nil {
            newProdSpecs.append(newProdSpecTwo!)
        }
        
        let newProdPrice = addedPrice.text // Turn into a double?
        let newProdImage = addedImage.image // turn into a string?
        
        //        //Creating Product Instance
        //        guard let nameInString = newProdName as? String else {return}
        //        guard let priceInDouble = newProdPrice as? Double else {return}
        //        guard let imageURLInString = newProdImage as? String else {return}
        //        guard let descriptionInString = newProdDescription as? String else {return}
        //        guard let measurementsInStringArray = newProdSpecs as? [String] else {return}
        //
        //        guard let roomCategory = getRoomCategory(product) else {return}
        //        guard let productCategory = getProductCategory(product) else {return}
        //        guard let storyCategory = getStoryCategory(product) else {return}
        //
        //        //to cache the downloaded images
        ////        let newProduct = Product(productIDAsString, nameInString, priceInDouble, imageURLInString, descriptionInString, measurementsInStringArray, reviewsInStringArray, storyCategory, roomCategory, productCategory )
        //
        //        self.products.append(newProduct)
        //        print("added product to array")
        
        
        
        //        saveButton.isEnabled = !text.isEmpty
        
        
    }
    
    // Camera & Image Buttons
    @IBAction func chooseImageTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func uploadImageTapped(_ sender: UIButton) {
        
        // Camera implementation
    }
    
    // Cancel add data.
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddToInventoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == storyTableView {
            return Story.stories.count
        } else if tableView == roomTableView {
            return RoomCategory.rooms.count
        } else {
            return StandardProductCategories.allStandardCategories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == storyTableView {
            
            guard let cell = storyTableView.dequeueReusableCell(withIdentifier: "StoryCell", for: indexPath) as? InventoryStoryTVCell else {
                print("Error creating Inventory tory Cell")
                return UITableViewCell()
            }
            cell.storyLabel.text = Story.stories[indexPath.row].storyName
            return cell
            
        } else if tableView == roomTableView {
            
            guard let cell = roomTableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as? InventoryRoomTVCell else {
                print("Error creating Inventory Room Cell")
                return UITableViewCell()
            }
            cell.roomLabel.text = RoomCategory.rooms[indexPath.row].roomName
            return cell

        } else {
            
            guard let cell = prodCategoryTableView.dequeueReusableCell(withIdentifier: "ProdCategoryCell", for: indexPath) as? InventoryProdCategoryTVCell else {
                print("Error creating Inventory ProdCategory Cell")
                return UITableViewCell()
            }
            cell.prodCategoryLabel.text = StandardProductCategories.allStandardCategories[indexPath.row].name
            return cell
        }
    }
}

extension AddToInventoryVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        selectedIndexPath = indexPath

        // checking and un checking
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            cell.accessoryType = UITableViewCellAccessoryType.none
            // removing data
            if tableView == storyTableView {
                addedStory.remove(Story.stories[indexPath.row].storyName)
                print("Selected Story: \(addedStory)")
            } else if tableView == roomTableView {
                addedRoom.remove(RoomCategory.rooms[indexPath.row].roomName)
                print("Selected Story: \(addedRoom)")
            } else {
                addedProductCategories.remove(StandardProductCategories.allStandardCategories[indexPath.row].name)
                print("Selected Story: \(addedProductCategories)")
            }
        } else {
            
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            
            // adding new data
            if tableView == storyTableView {
                addedStory.insert(Story.stories[indexPath.row].storyName)
                print("Selected Story: \(addedStory)")
            } else if tableView == roomTableView {
                addedRoom.insert(RoomCategory.rooms[indexPath.row].roomName)
                addedRoom.remove(RoomCategory.rooms[indexPath.row].roomName)
            } else {
                addedProductCategories.insert(StandardProductCategories.allStandardCategories[indexPath.row].name)
                print("Selected Story: \(addedProductCategories)")
            }
        }
    
    }
}











