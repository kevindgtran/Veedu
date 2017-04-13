//
//  ProfileViewController.swift
//  Veedu
//
//  Created by Kevin Tran on 4/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI

class ProfileViewController: UIViewController {
    
    //MARK: properties
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    //setup firebase authentication variables
    fileprivate var _authHandle: FIRAuthStateDidChangeListenerHandle!
    var user: FIRUser?
    var displayName = "Anonymous"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAuth()
    }
    
    //create configure authentication function
    func configureAuth() {
        _authHandle = FIRAuth.auth()?.addStateDidChangeListener { (auth: FIRAuth, user: FIRUser?) in
            //check if current user matches the FIRUser
            if let activeUser = user {
                
                
                User.configure(username: (user?.email)!)
                
                
                if self.user != activeUser {
                    self.user = activeUser
                    self.signedInStatus(isSignedIn: true)
                    let name = user!.email!.components(separatedBy: "@")[0]
                    self.displayName = name
                    //self.welcomeLabel.text = "Welcome, \(name)!"
                    
                }
            } else {
                self.signedInStatus(isSignedIn: false)
                self.loginSession()
            }
        }
    }
    
    func signedInStatus(isSignedIn: Bool) {
        signInButton.isHidden = isSignedIn
        signOutButton.isHidden = !isSignedIn
        
        if (isSignedIn) {
            //waiting to create profile view
        }
    }
    
    //present login session
    func loginSession() {
        let authViewController = FUIAuth.defaultAuthUI()!.authViewController()
        present(authViewController, animated: true, completion: nil)
    }
    
    deinit {
        //unregister the auth listener
        FIRAuth.auth()?.removeStateDidChangeListener(_authHandle)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: actions
    @IBAction func signOut(_ sender: UIButton) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            print("unable to sign out: \(error)")
        }
    }
    
}
