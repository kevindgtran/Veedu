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
        Firebase.shared.configureAuth(controller: self) { authorized in
            if authorized {
                print("in profile home successfull, successfully authenticated user")
                if let user = User.shared {
                    self.userName.text = user.username
                }
            } else {
                self.userNotLogedInAlert()
            }
            
        }
    }
    
    //MARK: actions
    @IBAction func logout(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            Firebase.shared = Firebase.reinitialize()
            self.userName.text = ""
            self.userNotLogedInAlert()
        } catch {
            print("unable to sign out: \(error)")
        }
    }
}
