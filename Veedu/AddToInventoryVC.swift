//
//  AddToInventoryVC.swift
//  Veedu
//
//  Created by Joy Umali on 4/11/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import AVFoundation

//extension Int {
//    static func random(random: Range<Int>) -> Int {
//        var offset = 0
//        
//        if range.startIndex < 0   // allow negative ranges
//        {
//            offset = abs(range.startIndex)
//        }
//        
//        let mini = UInt32(range.startIndex + offset)
//        let maxi = UInt32(range.endIndex   + offset)
//        
//        return Int(mini + arc4random_uniform(maxi - mini)) - offset
//    }
//}

class AddToInventoryVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: IBOutlets
    // TableView Controllers
    @IBOutlet weak var storyTableView: UITableView!
    @IBOutlet weak var roomTableView: UITableView!
    @IBOutlet weak var prodCategoryTableView: UITableView!
    
    @IBOutlet weak var addedProductName: UITextField?
    @IBOutlet weak var addedDescription: UITextView?
    @IBOutlet weak var addedSpecOne: UITextField?
    @IBOutlet weak var addedSpecTwo: UITextField?
    @IBOutlet weak var addedPrice: UITextField?
    @IBOutlet weak var addedImage: UIImageView!
    
    //var addedItems = [Product]()
    var addedStory: String?
    var addedRoom: Set<String> = []
    var addedProductCategories: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        //Encoding
        let image = UIImage(named: "NoImage.png")
        let imageData: NSData = UIImagePNGRepresentation(image!)! as NSData
        //Saved Image
        UserDefaults.standard.set(imageData, forKey: "savedImage")
        //Decode
        let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
        addedImage.image = UIImage(data: data as Data)
        //Request Authorization
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (authorized) in
            authorized ? print("AUTHORIZED!") : print("NO DICE!")
            
        }
    }
    
    // Save Button
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        //when tapped, all data added in the textfields and the imageView will be added to the firebase

        
        if let productName = self.addedProductName?.text, let productDescription = self.addedDescription?.text, let productPrice = self.addedPrice?.text {
            
            var productSpecifications = [String]()
            var productCategory: [String] = []
            if let spec1 = self.addedSpecOne?.text, let spec2 = self.addedSpecTwo?.text, let productStory = self.addedStory, let productCategories = self.addedProductCategories{
                
                productSpecifications.append(spec1)
                productSpecifications.append(spec2)
                productCategory.append(productCategories)
                let roomCategory = Array(self.addedRoom)
                
                var newProduct = [String: Any]()
                
               // var randomInt = Int.random(random: 55...500)
                var productId = "temp" + String(10)
                
                newProduct[Product.ProductKeys.productID] = productId
                newProduct[Product.ProductKeys.name] = productName
                newProduct[Product.ProductKeys.price] = productPrice
                newProduct[Product.ProductKeys.description] = productDescription
                newProduct[Product.ProductKeys.measurements] = productSpecifications
                newProduct[Product.ProductKeys.storyCategory] = productStory
                newProduct[Product.ProductKeys.roomCategory] = roomCategory
                newProduct[Product.ProductKeys.productCategory] = productCategory
                
                Firebase.shared.addProductToFirebase(data: newProduct)
                
            }
            else {
                incompleteAlert()
            }
            
        }else {
            incompleteAlert()
        }

    }
    
    func incompleteAlert() {
        let alertController = UIAlertController(title: "Hi!", message: "Please complete all the fields before saving!", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Camera & Image Buttons
    @IBAction func chooseImageTapped(_ sender: UIButton) {
        // Camera Access "Take Photo"
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let cameraImage = UIImagePickerController()
            cameraImage.delegate = self
            cameraImage.sourceType = UIImagePickerControllerSourceType.camera
            cameraImage.allowsEditing = false
            self.present(cameraImage, animated: true, completion: nil)

//            //Encoding
//            let image = UIImage(named: cameraImage)
//            let imageData: NSData = UIImagePNGRepresentation(image!)! as NSData
//            //Saved Image
//            UserDefaults.standard.set(imageData, forKey: "savedImage")
//            //Decode
//            let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
//            addedImage.image = UIImage(data: data as Data)
//            

            
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            addedImage.image = image
            
            print(image)
        } else {
            print("error with camera image")
        }
//        self.dismiss(animated: true, completion: nil) 

    }
    
//    @IBAction func saveButt(sender: AnyObject) {
//        var imageData = UIImageJPEGRepresentation(addedImage.image!, 6.0)
//        var compressedJPGImage = UIImage(data: imageData!)
//        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
//        
//        var alert = UIAlertView(title: "Image Saved",
//                                message: "Your image has been saved to Photo Library!",
//                                delegate: nil,
//                                cancelButtonTitle: "Ok")
//        alert.show()
//    }
    
    @IBAction func uploadImageTapped(_ sender: UIButton) {
        // Library Access "Choose Existing"
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Cancel add new product
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
        tableView.allowsMultipleSelectionDuringEditing = false
        
        
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
    
    // TO DO: Condense code below...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        // When tapped, if row is checked, uncheck it
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            cell.accessoryType = UITableViewCellAccessoryType.none
            // removing data
            if tableView == storyTableView {
                self.addedStory = nil
                print("Selected Story: \(addedRoom)")
                
            } else if tableView == roomTableView {
                addedRoom.remove(RoomCategory.rooms[indexPath.row].roomName)
                print("Selected Room: \(addedRoom)")
            } else {
                self.addedProductCategories = nil
                print("Selected Product Categories: \(String(describing: addedProductCategories))")
            }
        } else {
            
            if tableView == storyTableView {
                
                // removing checkmarks before adding current selection
                let section = indexPath.section
                let numberOfRows = tableView.numberOfRows(inSection: section)
                for row in 0..<numberOfRows {
                    if let cell = tableView.cellForRow(at:IndexPath(row: row, section: section)) {
                        cell.accessoryType = row == indexPath.row ? .checkmark : .none
                    }
                }
                
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                addedStory = Story.stories[indexPath.row].storyName
                print("Selected Story1: \(String(describing: addedStory))")
                
                if let addedStory = addedStory { // if there is a story selected already, replace the variable with the new selected storyName.
                    self.addedStory = Story.stories[indexPath.row].storyName
                    print("Selected Story1: \(addedStory)")
                }
            } else if tableView == roomTableView {
                
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                
                addedRoom.insert(RoomCategory.rooms[indexPath.row].roomName)
                print("Selected Room: \(addedRoom)")
                
            } else {
                let section = indexPath.section
                let numberOfRows = tableView.numberOfRows(inSection: section)
                for row in 0..<numberOfRows {
                    if let cell = tableView.cellForRow(at:IndexPath(row: row, section: section)) {
                        cell.accessoryType = row == indexPath.row ? .checkmark : .none
                    }
                }
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                addedProductCategories = StandardProductCategories.allStandardCategories[indexPath.row].name
                if let addedProductCategories = addedProductCategories {
                    self.addedProductCategories = StandardProductCategories.allStandardCategories[indexPath.row].name
                    print("Selected Product Categories: \(addedProductCategories)")
                }
            }
        }
    }
}










