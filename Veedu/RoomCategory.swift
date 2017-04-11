//
//  RoomCategory.swift
//  Veedu
//
//  Created by Joy Umali on 4/8/17.
//  Copyright © 2017 com.example. All rights reserved.
//


import Foundation
import UIKit

struct RoomCategory {
    
    let roomName: String
    let firebaseName: String
    
    static let rooms: [RoomCategory] = [
    
        RoomCategory(roomName: "Living Room", firebaseName: "livingRoom"),
        RoomCategory(roomName: "Bedroom", firebaseName: "bedRoom"),
        RoomCategory(roomName: "Kitchen & Dining", firebaseName: "kitchenDiningRoom"),
        RoomCategory(roomName: "Bathroom", firebaseName: "bathRoom")
//        RoomCategory(roomName: "Garden"),
//        RoomCategory(roomName: "Office")
    ]
    
    
}
