//
//  ProfileHomeVC.swift
//  Veedu
//
//  Created by Kevin Tran on 4/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import Firebase

class ProfileHomeVC: UIViewController {
    
    //MARK: properties
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Firebase.shared.configureAuth {print("in profile home successfull, successfully authenticated user")}
    }
    
    //MARK: actions
    @IBAction func logout(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            print("unable to sign out: \(error)")
        }
    }
}
