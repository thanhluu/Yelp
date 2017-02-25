//
//  BusinessFilterSettings.swift
//  Yelp
//
//  Created by Luu Tien Thanh on 2/24/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

let maxDistance: Double = 40000

class BusinessFilterSettings {
    var with: String?
    var sort: YelpSortMode!
    var categories = [String]()
    var deals: Bool?
    
    var limit: Int?
    var offset: Int?
    var distance: Double!
    
    static let sharedInstance = BusinessFilterSettings()
}
