//
//  Authentication.swift
//  Veedu
//
//  Created by Prathiba Lingappan on 4/11/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuthUI

class Authentication {
    
    //setup firebase authentication variables
    fileprivate var _authHandle: FIRAuthStateDidChangeListenerHandle!
    var user: FIRUser?
    var displayName = "Anonymous"
    
    static let shared = Authentication()
    
    //create configure authentication function
    func configureAuth(viewController: UIViewController) {
        
        print("Inside configureAuth")
        
        _authHandle = FIRAuth.auth()?.addStateDidChangeListener { (auth: FIRAuth, user: FIRUser?) in
            //check if current user matches the FIRUser
            if let activeUser = user {
                
                print("Inside FIRST IF in configureAuth")
                
                User.configure(username: (user?.email)!)
                
                if self.user != activeUser {
                    
                    print("Inside SECOND IF in configureAuth")
                    
                    self.user = activeUser
                    let name = user!.email!.components(separatedBy: "@")[0]
                    self.displayName = name
        
                    //return true
                }
            }
            else {
                
                print("Inside ELSE in configureAuth")
                //print(auth)
                //self.signedInStatus(isSignedIn: false)
                self.loginSession(viewController: viewController)
            }
        }
        
    }
    
//    func signedInStatus(isSignedIn: Bool) {
//        signInButton.isHidden = isSignedIn
//        signOutButton.isHidden = !isSignedIn
//        
//        if (isSignedIn) {
//            //waiting to create profile view
//        }
//    }
    
    //present login session
    func loginSession(viewController: UIViewController) {
        
        var topController = UIApplication.shared.keyWindow?.rootViewController
        
        while let controller = topController?.presentedViewController {
            topController = controller
        }
        
        print("In loginSession")
        
        let authViewController = FUIAuth.defaultAuthUI()!.authViewController()
        topController?.present(authViewController, animated: true, completion: nil)
    }
}
