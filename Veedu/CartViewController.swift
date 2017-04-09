//
//  CartViewController.swift
//  Veedu
//
//  Created by Kevin Tran on 4/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import CoreData

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tempProductArray: [NSManagedObject] = []
    
    //MARK: properties
    @IBOutlet weak var cartItemCountLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cartItemCountLabel.text = "\(tempProductArray.count)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CartProduct")
        do {
            tempProductArray = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch data")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempProductArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        let someStuff: NSManagedObject = tempProductArray[indexPath.row]
        cell.cartTitleLabel?.text = someStuff.value(forKeyPath: "cartProductName") as? String
        
        return cell
    }
    
    //save function
    func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CartProduct", in: managedContext)!
        
        let newStuff = NSManagedObject(entity: entity, insertInto: managedContext)
        
        newStuff.setValue(name, forKeyPath: "cartProductName")
        
        do {
            try managedContext.save()
            tempProductArray.append(newStuff)
        } catch let error as NSError {
            print("Could not save item")
        }
    }
    
    //MARK: actions
    @IBAction func tempAddButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Item", message: "Add a new item", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let nameTextField = alert.textFields?.first,
                let nameToSave = nameTextField.text else {
                    return
            }
            
            self.save(name: nameToSave)
            self.cartTableView.reloadData()
            self.cartItemCountLabel.text = "\(self.tempProductArray.count)"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.textFields?[0].placeholder = "Title"
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

/*
 Setup Core Data - persist data upon loading
 1. import core data (app delegate & view controllers)
 2. (in app delegate)
 add persist container variable
 3. create data model and attributes
 4. (in view controller)
 create empty array of type NSManagedObject
 create save function, setvalue function, save/ print error, reload table
 5. (in view will appear function)
 fetch data, populate, refresh data
 6. (in view controller)
 create add function for button action
 */
