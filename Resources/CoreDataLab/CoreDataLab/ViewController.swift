//
//  ViewController.swift
//  CoreDataLab
//
//  Created by Prathiba Lingappan on 4/5/17.
//  Copyright © 2017 Prathiba Lingappan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var products = [Product]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        products = fetchProducts()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    @IBAction func add(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Name", message: "Enter the product name", preferredStyle: .alert)
        
        let save = UIAlertAction(title: "Save", style: .default) { (action) in
            
            guard let text = alertController.textFields?.first?.text else {return}
            self.saveProduct(text)
            self.tableView.reloadData()
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField()
        alertController.addAction(save)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    func saveProduct(_ name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Problem in AppDelegate")
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Product", in: managedContext) else {
            print("Problem in managed context")
            return
        }
        let product = Product(entity: entity, insertInto: managedContext)
        
        product.name = name
        
        do {
            try managedContext.save()
            products.append(product)
            print("Success saving product!!!!")
        }
        catch {
            print("Error saving product to core data: \(error)")
        }
        
    }
    
    func fetchProducts() -> [Product]{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Problem in fetching AppDelegate")
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = Product.createFetchRequest()
        
        do {
            let products = try managedContext.fetch(fetchRequest)
            print("Success fetching product!!!!")
            return products
        }
        catch {
            print("Error saving product to core data: \(error)")
            return []
        }

    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = products[indexPath.row].name
        
        return cell
    }
}

