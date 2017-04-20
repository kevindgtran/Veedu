//
//  Product+CoreDataProperties.swift
//  CoreDataLab
//
//  Created by Prathiba Lingappan on 4/5/17.
//  Copyright © 2017 Prathiba Lingappan. All rights reserved.
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product");
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var user: User?

}

// MARK: Generated accessors for user
extension Product {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: User)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: User)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}
