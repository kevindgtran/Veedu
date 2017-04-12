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
    @IBOutlet weak var addedProductName: UITextField!
    @IBOutlet weak var addedDescription: UITextView!
    @IBOutlet weak var addedSpecOne: UITextField!
    @IBOutlet weak var addedSpecTwo: UITextField!
    @IBOutlet weak var addedPrice: UITextField!
    @IBOutlet weak var addedImage: UIImageView!
    
    var addedItem = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // empty/reload textfields
        
    }
    
    // MARK: IBActions
    
    // Story Switches. ONLY CAN SELECT ONE.
    @IBAction func farmHouseSelected(_ sender: UISwitch) {
    }
    
    @IBAction func industrialSelected(_ sender: UISwitch) {
    }
    
    @IBAction func midCentModSelected(_ sender: UISwitch) {
    }
    
    @IBAction func otherSelected(_ sender: UISwitch) {
    }
    
    // Room Switches. ONLY CAN SELECT ONE.
    @IBAction func livingroomSelected(_ sender: UISwitch) {
    }

    @IBAction func bedroomSelected(_ sender: UISwitch) {
    }
    
    @IBAction func kitchenDiningSelected(_ sender: UISwitch) {
    }
    
    @IBAction func bathroomSelected(_ sender: UISwitch) {
    }
    
    // Product Category Switches.  CAN SELECT MULTIPLE.
    
    @IBAction func furnitureSelected(_ sender: UISwitch) {
    }
    
    @IBAction func lightingSelected(_ sender: UISwitch) {
    }
    
    @IBAction func accessorySelected(_ sender: UISwitch) {
    }
    
    @IBAction func textileSelected(_ sender: UISwitch) {
    }
    
    @IBAction func cookwareSelected(_ sender: UISwitch) {
    }
    
    @IBAction func diningwareSelected(_ sender: UISwitch) {
    }
    
    @IBAction func smallApplianceSelected(_ sender: UISwitch) {
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
    }
    
}
