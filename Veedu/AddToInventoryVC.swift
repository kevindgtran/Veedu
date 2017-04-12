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
    // Do we want to add a SpecThree?
    
    @IBOutlet weak var addedPrice: UITextField!
    
    @IBOutlet weak var addedImage: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: IBActions
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
    }

    @IBAction func uploadImageTapped(_ sender: UIButton) {
        
        // Camera implementation
    }
    
    
}
