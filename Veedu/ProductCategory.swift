//
//  ProductCategory.swift
//  Veedu
//
//  Created by Joy Umali on 4/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//


import Foundation

struct ProductCategory {
    
    let productCategoryName: String
    let productCategoryImage: String
    let firebaseCategoryName: String
   
    // Index0 - LivingRoom
    static let livingRoomProdCategories: [ProductCategory] = [
        // LivingRoom
        ProductCategory(productCategoryName: "Furniture", productCategoryImage: "LivingFurniture", firebaseCategoryName: "furniture"),
        ProductCategory(productCategoryName: "Lighting", productCategoryImage: "LivingLighting", firebaseCategoryName: "lighting"),
        ProductCategory(productCategoryName: "Textiles", productCategoryImage: "LivingThrows", firebaseCategoryName: "textile")
//        ProductCategory(productCategoryName: "PIllows", productCategoryImage: "LivingPillows", firebaseCategoryName: ""),
//        ProductCategory(productCategoryName: "Rugs", productCategoryImage: "LivingRugs"),
        
        ]
    
    // Index1 - BedRoom
    static let bedroomProdCategories: [ProductCategory] = [
        // Bedroom
        ProductCategory(productCategoryName: "Furniture", productCategoryImage: "BedFurniture", firebaseCategoryName: "furniture"),
        ProductCategory(productCategoryName: "Bedding", productCategoryImage: "BedTextiles", firebaseCategoryName: "textile"),
        ProductCategory(productCategoryName: "Lighting", productCategoryImage: "BedLighting", firebaseCategoryName: "lighting"),
        ProductCategory(productCategoryName: "Accessories", productCategoryImage: "BedAccessories", firebaseCategoryName: "accessory")
        
    ]
    
    // Index2 - Kitchen&Dining
    static let kitchenDiningProdCategories: [ProductCategory] = [
        // Kitchen&Dining
        ProductCategory(productCategoryName: "Furniture", productCategoryImage: "DiningFurniture", firebaseCategoryName: "furniture"),
        ProductCategory(productCategoryName: "Diningware", productCategoryImage: "Diningware", firebaseCategoryName: "diningware"),
        ProductCategory(productCategoryName: "Cookware", productCategoryImage: "Cookware", firebaseCategoryName: "cookware"),
        ProductCategory(productCategoryName: "Small Appliances", productCategoryImage: "SmallAppliances", firebaseCategoryName: "smallAppliance")
       // ProductCategory(productCategoryName: "Barware", productCategoryImage: "DiningBarware")

        
        ]
    

    //Index3 - Bathroom
    static let bathroomProdCategories: [ProductCategory] = [
        // Bathroom
     // ProductCategory(productCategoryName: "Furniture", productCategoryImage: "BathFurniture"),
        ProductCategory(productCategoryName: "Textiles", productCategoryImage: "BathTextiles",firebaseCategoryName : "textile"),
        ProductCategory(productCategoryName: "Accessories", productCategoryImage: "BathAccessories", firebaseCategoryName: "accessory")
        
    ]
    
}

/*
 ["LivingFurniture":"Furniture", "LivingAccessories":"Accessories", "LivingLighting":"Lighting", "LivingThrows":"Textiles", "LivingPillows":"Pillows", "LivingRugs":"Rugs"],
 ["BedAccessories":"Accessories","BedFurniture":"Furniture", "BedLighting":"Lighting", "BedTextiles":"Bedding"],
 ["Cookware":"Cookware", "DiningFurniture":"Furniture", "Diningware":"Diningware", "DiningBarware":"Barware", "SmallAppliances":"SmallAppliances"],
 ["BathAccessories":"Accessories", "BathTextiles":"Textiles"]
 
 */
 
 
