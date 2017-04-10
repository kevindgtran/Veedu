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
    
    var coreDataProductNameArray: [NSManagedObject] = []
    
    //MARK: properties
    @IBOutlet weak var cartItemCountLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //fetch the data from the NSManagedObject and populate when the page appears
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CartProduct")
        do {
            //create fetch request from NSManagedObject and store objects directly into array
            coreDataProductNameArray = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch data")
        }
        
        self.cartItemCountLabel.text = "\(self.coreDataProductNameArray.count)"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataProductNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        
        //update the table with the newly created NSManaged item
        let someStuff: NSManagedObject = coreDataProductNameArray[indexPath.row]
        cell.cartTitleLabel?.text = someStuff.value(forKeyPath: "name") as? String
        
        return cell
    }
    
    //save function
    func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CartProduct", in: managedContext)!
        
        let newProductName = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //set the new product name to the NSManagedObject
        newProductName.setValue(name, forKeyPath: "name")
        
        //save new product to our NSManagedObjects and add to our array
        do {
            try managedContext.save()
            coreDataProductNameArray.append(newProductName)
        } catch let error as NSError {
            print("Could not save product name to array")
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
            self.cartItemCountLabel.text = "\(self.coreDataProductNameArray.count)"
            
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
    create view will appear function - create fetch, data populate, refresh data
 5. (in view controller)
    create add function for button action to save
 */
