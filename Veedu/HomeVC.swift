//
//  HomeVC.swift
//  Veedu
//
//  Created by Joy Umali on 4/7/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    var storyCategories = Story.stories
    
//    var storyCategory = Story()
    
    var selectedIndexPath: IndexPath?
    
    @IBOutlet weak var storyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}

// MARK: DATA SOURCE

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = storyTableView.dequeueReusableCell(withIdentifier: "StoryCell", for: indexPath) as?StoryTableViewCell else {
            print("***Error with StoryCell***")
            return UITableViewCell()
        }
        
//        let storyCategory = storyCategories[indexPath.row]

        // Story Images in TableView
        if let storyImage = self.storyCategories[indexPath.row].storyImage {
            cell.storyImageView.image = UIImage(named: storyImage)
        } else {
            print("***Error retrieving image from assets.***")
        }
        
        // Story Labels in TableView
        cell.storyNameLabel.text = storyCategories[indexPath.row].storyName
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // user selected a story category.
        selectedIndexPath = indexPath
        
        // connect to Prathiba's ProductsPerCategoryVC
        performSegue(withIdentifier: "ProductCell", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? ProductsPerCategoryVC {
//            if let selectedIndexPath = selectedIndexPath {
//                destination.
//            }
//        }
//    }
//    
    
    
}
