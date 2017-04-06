//
//  ViewController.swift
//  Veedu
//
//  Created by Kevin Tran on 4/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: properties
    var ref: FIRDatabaseReference!
    var productsFromFirebase: [FIRDataSnapshot]! = []
    var storageRef: FIRStorageReference!
    var remoteConfig: FIRRemoteConfig!
    var keyboardOnScreen = false
    fileprivate var _refHandle: FIRDatabaseHandle!
    fileprivate var _authHandle: FIRAuthStateDidChangeListenerHandle!
    var user: FIRUser?
    
    //MARK: outlets
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signedInStatus(isSignedIn: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsFromFirebase.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        let row = indexPath.row
        
        let productSnapshot: FIRDataSnapshot! = productsFromFirebase[row]
        let product = productSnapshot.value as! [String:Any]
        let name = product[Product.ProductKeys.name] ?? "[name]"
        
        cell.titleLabel.text = name as? String
        return cell
    }
    
    func signedInStatus(isSignedIn: Bool) {
        
        if (isSignedIn) {
            configureDatabase()
            configureStorage()
        }
    }
    
    func  configureDatabase() {
        ref = FIRDatabase.database().reference()
        _refHandle = ref.child("allProducts").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            self.productsFromFirebase.append(snapshot)
            self.mainTableView.insertRows(at: [IndexPath(row: self.productsFromFirebase.count - 1, section: 0)], with: .automatic)
        }
    }
    
    func configureStorage() {
        storageRef = FIRStorage.storage().reference()
    }
    
    deinit {
        ref.child("allProducts").removeObserver(withHandle: _refHandle)
    }
}


/*
STEPS:
1. connect to firebase >> upload JSON >> create firebase variables
2. create signedinstatus function >> signedin status >> true
3. create configureDatabase function
4. create configureStorage function
5. create deinit function (stops listeners)
6. call configureDatabase & configureStorage

NOTES: 
 setup database rules to true (temporarily)
 update projects target >> info >> client ID >>URL Type >> URL Scheme with GoogleService-info.plist, REVERSED CLIENT_ID
 */














