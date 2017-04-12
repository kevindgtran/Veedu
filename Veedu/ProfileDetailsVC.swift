//
//  ProfileDetailsVC.swift
//  Veedu
//
//  Created by Kevin Tran on 4/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ProfileDetailsVC: UIViewController {

    
    //MARK: properties
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var shipping: UITextView!
    @IBOutlet weak var billing: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func backButton(_ sender: Any) {
    }
    
    @IBAction func saveButton(_ sender: Any) {
    
        //saving all information to firebase
    
    
    
    
    
    }

}
