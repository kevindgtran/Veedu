//
//  User.swift
//  Veedu
//
//  Created by Prathiba Lingappan on 4/11/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation

class User {
    
    static var shared: User?
    
    var firstName: String?
    var lastName: String?
    var username: String
    var password: String?
    var billing: String?
    var shipping: String?
    var orderHistory: [String] = []
    var inCart: [Product] = []
    var favorite: [Product] = []
    
    private init(username: String, password: String?) {
        self.username = username
        self.password = password
    }
    
    static func configure(username: String, password: String? = nil) {
        User.shared = User(username: username, password: password)
    }
    
    func addToFavorite(_ product: Product) {
        favorite.append(product)
        for i in favorite {
            print(i.productName)
        }
    }
    
    func addToCart(_ product: Product) {
        inCart.append(product)
        for i in favorite {
            print(i.productName)
        }
    }
    
    func addOrderHistory(_ orderNumber: String) {
        orderHistory.append(orderNumber)
    }
    
//    func setBilling(_ billing: String) {
//        self.billing = billing
//    }
    
}
