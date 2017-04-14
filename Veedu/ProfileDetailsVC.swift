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
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //guard let user = User.shared else {return}
        
//        if let firstName = user.firstName {
//            setView(user)
//        }
//        else {
//            Firebase.shared.getUserFromFirebase {
//                self.setView(user)
//            }
//        }
        
        Firebase.shared.getUserFromFirebase {
            //self.setView(user)
             guard let user = User.shared else {return}
            
            guard let firstName = user.firstName else {
                print("User does not have first name")
                return
            }
            
            print("First Name: \(firstName)")
            
            guard let lastName = user.lastName else {
                print("User does not have last name")
                return
            }
            print("Last Name: \(lastName)")
            
            guard let shipping = user.shipping else {
                print("User does not have shipping address")
                return
            }
            print("shipping: \(shipping)")
            
            guard let billing = user.billing else {
                print("User does not have billing address")
                return
            }
            print("billing: \(billing)")
            
            self.firstName.text = firstName
            self.lastName.text = lastName
            self.billing.text = billing
            self.shipping.text = shipping

        }
        
    }
    
//    func setView(_ user: User) {
//        guard let firstName = user.firstName else {
//            print("User does not have first name")
//            return
//        }
//        
//        print("First Name: \(firstName)")
//        
//        guard let lastName = user.lastName else {
//            print("User does not have last name")
//            return
//        }
//        print("Last Name: \(lastName)")
//        
//        guard let shipping = user.shipping else {
//            print("User does not have shipping address")
//            return
//        }
//        print("shipping: \(shipping)")
//        
//        guard let billing = user.billing else {
//            print("User does not have billing address")
//            return
//        }
//        print("billing: \(billing)")
//        
//        self.firstName.text = firstName
//        self.lastName.text = lastName
//        self.billing.text = billing
//        self.shipping.text = shipping
//
//    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
    
        //saving to local
        guard let user = User.shared else {return}
        
        user.firstName = self.firstName.text
        user.lastName = self.lastName.text
        user.billing = self.billing.text
        user.shipping = self.shipping.text
    
        //saving all information to firebase
        user.username = user.username.components(separatedBy: "@")[0]

        var newUser = [String: String]()
        
        newUser[User.UserKeys.firstName] = self.firstName.text
        newUser[User.UserKeys.lastName] = self.lastName.text
        newUser[User.UserKeys.billing] = self.billing.text
        newUser[User.UserKeys.shipping] = self.shipping.text
        newUser[User.UserKeys.username] = user.username
        
        Firebase.shared.addUserToFirebase(data: newUser)
    
    }

}
