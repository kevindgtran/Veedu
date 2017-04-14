//
//  PurchaseVC.swift
//  Veedu
//
//  Created by Kevin Tran on 4/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class PurchaseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tempArray = ["one"]
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var purchaseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = purchaseTableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as! PurchaseTableViewCell
        cell.orderDate.text = tempArray[indexPath.row]
        cell.confirmationNumber.text = tempArray[indexPath.row]
        cell.orderTotal.text = tempArray[indexPath.row]
        
        return cell
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
