//
//  FavoritesUIViewController.swift
//  Veedu
//
//  Created by Kevin Tran on 4/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class FavoritesUIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tempArray = [String]()
    //var tempArray = ["couch"]
    
    //MARK: properties
    @IBOutlet weak var itemsAmountLabel: UILabel!
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var sadFaceImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tempArray.count == 0 {
            favoritesTableView.isHidden = true
            sadFaceImage.isHidden = false
        } else {
            itemsAmountLabel.text = "\(tempArray.count)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoritesTableViewCell
        cell.itemLabel.text = tempArray[indexPath.row]
        return cell
    }
}
