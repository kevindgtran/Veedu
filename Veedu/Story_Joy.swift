//
//  Story.swift
//  Veedu
//
//  Created by Joy Umali on 4/7/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import UIKit

struct Story {
    
    let storyName: String
    let storyImage: String?
    
    static let stories: [Story] = [
    
    // some are placeholder names and images
    Story(storyName: "Industrial", storyImage: "Industrial"),
    Story(storyName: "Rustic", storyImage: "Rustic"),
    Story(storyName: "Mid-Century Modern", storyImage: "Beijing"),
    Story(storyName: "New Frontier", storyImage: "NewFrontier"),
    Story(storyName: "SomethingOrOther", storyImage: "Other"),
    ]
    
    
}
