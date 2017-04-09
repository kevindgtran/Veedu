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
    
    static let rooms: [RoomCategory] = [
    
        RoomCategory(roomName: "Living Room"),
        RoomCategory(roomName: "Bedroom"),
        RoomCategory(roomName: "Kitchen & Dining"),
        RoomCategory(roomName: "Bathroom")
//        RoomCategory(roomName: "Garden"),
//        RoomCategory(roomName: "Office")
    ]
    
    
}
