//
//  PurchaseVC.swift
//  Veedu
//
//  Created by Kevin Tran on 4/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class PurchaseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tempArray = [""]
    
    @IBOutlet weak var purchaseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = purchaseTableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as! PurchaseTableViewCell
        cell.orderDate.text = "04/ 14/ 2017"
        cell.confirmationNumber.text = "XYZ9735"
        cell.orderTotal.text = "350.00"
        
        return cell
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
