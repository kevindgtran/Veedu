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
    // TODO: Add IBOutlets for the Categorie Dropdowns or Switches...
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
    
    @IBAction func uploadImageTapped(_ sender: UIButton) {
        
        // Camera implementation
    }
    
    
}
