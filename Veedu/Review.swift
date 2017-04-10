//
//  Review.swift
//  Veedu
//
//  Created by Prathiba Lingappan on 4/7/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation

class Review {
    
    var productID: String
    var title: String
    var rating: Double
    var content: String
    
    init(_ productID: String, _ title: String, _ rating: Double, _ content: String) {
        self.title = title
        self.rating = rating
        self.content = content
        self.productID = productID
    }
    
    struct ReviewKeys {
        static let title = "title"
        static let rating = "rating"
        static let content = "review"
        static let productID = "productID"
    }
}
