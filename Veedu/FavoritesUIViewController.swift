//
//  FavoritesUIViewController.swift
//  Veedu
//
//  Created by Kevin Tran on 4/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import CoreData

class FavoritesUIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favoritesProductNameArray: [NSManagedObject] = []
    
    //MARK: properties
    @IBOutlet weak var itemsAmountLabel: UILabel!
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var sadFaceImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //save function
    func save(name: String) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
//        let entity = NSEntityDescription.entity(forEntityName: "FavoritesProduct", in: managedContext)!
//        
//        let newFavoritesProductName = NSManagedObject(entity: entity, insertInto: managedContext)
//        
//        //set the new product name to the NSManagedObject
//        newFavoritesProductName.setValue(name, forKeyPath: "name")
//        
//        //save new product to our NSManagedObjects and add to our array
//        do {
//            try managedContext.save()
//            favoritesProductNameArray.append(newFavoritesProductName)
//        } catch let error as NSError {
//            print("Could not save product name to array")
//        }
    }
    
    //update will appear function
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        //fetch the data from the NSManagedObject and populate when the page appears
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoritesProduct")
//        do {
//            //create fetch request from NSManagedObject and store objects directly into array
//            favoritesProductNameArray = try managedContext.fetch(fetchRequest)
//        } catch let error as NSError {
//            print("Could not fetch data")
//        }
//        
//        //update total items counter
//        if favoritesProductNameArray.count > 0 {
//            self.itemsAmountLabel.text = "\(self.favoritesProductNameArray.count)"
//        } else {
//            self.itemsAmountLabel.text = "0"
//            favoritesTableView.isHidden = true
//            sadFaceImage.isHidden = false
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesProductNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as! FavoritesTableViewCell
        
        let newFav: NSManagedObject = favoritesProductNameArray[indexPath.row]
        cell.favoritesNameLabel?.text = newFav.value(forKeyPath: "name") as? String
        return cell
    }
    
    //swipe to delete and custom color
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let remove = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
            self.favoritesProductNameArray.remove(at: indexPath.row)
            self.favoritesTableView.reloadData()
        }
        remove.backgroundColor = UIColor(red:0.91, green:0.29, blue:0.24, alpha:1.0)
        return[remove]
    }
    
    //MARK: actions
    @IBAction func addFavoriteButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Favorite", message: "Add new item", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let nameTextField = alert.textFields?.first,
                let nameToSave = nameTextField.text else {
                    return
            }
            
            self.save(name: nameToSave)
            self.favoritesTableView.isHidden = false
            self.sadFaceImage.isHidden = true
            self.favoritesTableView.reloadData()
            self.itemsAmountLabel.text = "\(self.favoritesProductNameArray.count)"
            
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
