//
//  Item.swift
//  Veedu
//
//  Created by Kevin Tran on 4/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import UIKit

class Product {
    
    var productID: String
    var productName: String
    var productPrice: Double
    var productImageURL: String
    var productImage: UIImage?
    var productDescription: String
    var productSpecifications: [String]
    var productReviews: [String]?
    var storyCategory: String
    var roomCategory: [String]
    var productCategory: [String]
    
    init(_ productID: String, _ productName: String, _ productPrice: Double, _ productImageURL: String, _ productDescription: String, _ productSpecifications: [String], _ productReviews: [String]?, _ storyCategory: String, _ roomCategory: [String], _ productCategory: [String]) {
        
        self.productID = productID
        self.productName = productName
        self.productPrice = productPrice
        self.productImageURL = productImageURL
        self.productDescription = productDescription
        self.productSpecifications = productSpecifications
        self.productReviews = productReviews
        self.storyCategory = storyCategory
        self.roomCategory = roomCategory
        self.productCategory = productCategory
        
    }
    
    static func downloadImage(_ imageURL: String, _ completion: @escaping(UIImage) -> Void) {
        
        guard let url = URL(string: imageURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                print("download image - first guard- else")
                return
            }
            guard let image = UIImage(data: data) else {
                print("download image - second - guard - else")
                return
            }
            print("Fetched Image")
            completion(image)
        }
        task.resume()
        
    }
    
    struct ProductKeys {
        static let productID = "productID"
        static let name = "name"
        static let price = "price"
        static let imageURL = "imageURL"
        static let description = "description"
        static let measurements = "specifications"
        static let productReviews = "productReviews"
        static let productCategory = "productCategory"
        static let roomCategory = "roomCategory"
        static let storyCategory = "storyCategory"
    }

}
