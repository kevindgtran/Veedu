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
    
    var productName: String
    var productPrice: Double
    var productImageURL: String
    var productImage: UIImage?
    
    init(_ productName: String, _ productPrice: Double, _ productImageURL: String) {
        self.productName = productName
        self.productPrice = productPrice
        self.productImageURL = productImageURL
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
        static let name = "name"
        static let price = "price"
        static let imageURL = "imageURL"
    }

}
