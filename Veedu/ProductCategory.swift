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
    
    // Index0 - LivingRoom
    static let livingRoomProdCategories: [ProductCategory] = [
        // LivingRoom
        ProductCategory(productCategoryName: "Furniture", productCategoryImage: "LivingFurniture"),
        ProductCategory(productCategoryName: "Lighting", productCategoryImage: "LivingLighting"),
        ProductCategory(productCategoryName: "Textiles", productCategoryImage: "LivingThrows"),
        ProductCategory(productCategoryName: "Pillows", productCategoryImage: "LivingPillows"),
        ProductCategory(productCategoryName: "Rugs", productCategoryImage: "LivingRugs"),

        ]
    
    // Index1 - BedRoom
    static let bedroomProdCategories: [ProductCategory] = [
        // Bedroom
        ProductCategory(productCategoryName: "Furniture", productCategoryImage: "BedFurniture"),
        ProductCategory(productCategoryName: "Bedding", productCategoryImage: "BedTextiles"),
        ProductCategory(productCategoryName: "Lighting", productCategoryImage: "BedLighting"),
        ProductCategory(productCategoryName: "Accessories", productCategoryImage: "BedAccessories")
        
    ]
    
    // Index2 - Kitchen&Dining
    static let kitchenDiningProdCategories: [ProductCategory] = [
        // Kitchen&Dining
        ProductCategory(productCategoryName: "Furniture", productCategoryImage: "DiningFurniture"),
        ProductCategory(productCategoryName: "Diningware", productCategoryImage: "Diningware"),
        ProductCategory(productCategoryName: "Cookware", productCategoryImage: "Cookware"),
        ProductCategory(productCategoryName: "Small Appliances", productCategoryImage: "SmallAppliances"),
        ProductCategory(productCategoryName: "Barware", productCategoryImage: "DiningBarware")

        
        ]
    

    //Index3 - Bathroom
    static let bathroomProdCategories: [ProductCategory] = [
        // Bathroom
     // ProductCategory(productCategoryName: "Furniture", productCategoryImage: "BathFurniture"),
        ProductCategory(productCategoryName: "Textiles", productCategoryImage: "BathTextiles"),
        ProductCategory(productCategoryName: "Accessories", productCategoryImage: "BathAccessories")
        
    ]
    
}

/*
 ["LivingFurniture":"Furniture", "LivingAccessories":"Accessories", "LivingLighting":"Lighting", "LivingThrows":"Textiles", "LivingPillows":"Pillows", "LivingRugs":"Rugs"],
 ["BedAccessories":"Accessories","BedFurniture":"Furniture", "BedLighting":"Lighting", "BedTextiles":"Bedding"],
 ["Cookware":"Cookware", "DiningFurniture":"Furniture", "Diningware":"Diningware", "DiningBarware":"Barware", "SmallAppliances":"SmallAppliances"],
 ["BathAccessories":"Accessories", "BathTextiles":"Textiles"]
 
 */
 
 
