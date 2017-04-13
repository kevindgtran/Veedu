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
    var inCart: [String] = []
    var favorite: [String] = []
    
    
    
    private init(username: String, password: String?) {
        self.username = username
        self.password = password
    }
    
    static func configure(username: String, password: String? = nil) {
        User.shared = User(username: username, password: password)
    }
    
    func addToFavorite(_ product: String) {
        favorite.append(product)
        for i in favorite {
            print("added to local: \(i)")
        }
    }
    
    func addToCart(_ product: String) {
        
        //print("In User - addToCart")
        
        inCart.append(product)
        for i in inCart {
            //print("added to local: \(i)")
        }
    }
    
    func removeFromCart(_ productId: String) {
        for i in 0..<inCart.count {
            if inCart[i] == productId {
                inCart.remove(at: i)
            }
        }
    }
    
    func removeFromFavorite(_ productId: String) {
        for i in 0..<favorite.count {
            if favorite[i] == productId {
                favorite.remove(at: i)
            }
        }
    }
    
    func addOrderHistory(_ orderNumber: String) {
        orderHistory.append(orderNumber)
    }
    
    struct UserKeys {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let username = "userName"
        static let password = "password"
        static let billing = "billing"
        static let shipping = "shipping"
        static let orderHistory = "orderHistory"
        static let inCart = "inCart"
        static let favorite = "favorite"
        
    }

    
}
