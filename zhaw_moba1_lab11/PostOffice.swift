//
//  PostOffice.swift
//  zhaw_moba1_lab11
//
//  Created by José Miguel Rota on 04.12.16.
//  Copyright © 2016 José Miguel Rota. All rights reserved.
//

import Foundation

class PostOffice {
    let x: Double
    let y: Double
    var name: String?
    var brand: String?
    var amenity: String?
    var website: String?
    var altName: String?
    var operatorName: String?
    var address = Address()
    var contact = Contact()
    var openingHours: String?
    var wheelChair = false
    
    required init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    func withinBounds(_ x: Double, y: Double, radius: Double) -> Bool {
        let maxX = x + radius
        let minX = x - radius
        let minY = y - radius
        let maxY = y + radius
        
        if (self.x >= minX && self.x <= maxX) {
            return self.y >= minY && self.y <= maxY
        }
        
        return false
    }
}
