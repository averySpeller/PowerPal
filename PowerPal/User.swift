//
//  User.swift
//  PowerPal
//
//  Created by Avery Speller on 2018-03-16.
//  Copyright © 2018 Avery Speller. All rights reserved.
//

import Foundation

class User {

    var id: Int
    var height: Int
    var weight: Int
    var benchMax: Int
    var squatMax: Int
    var DLMax: Int
    var wilks: Double
    
    init(id: Int, height: Int,weight: Int, benchMax: Int, squatMax: Int, DLMax: Int, wilks: Double ){
        self.id = id
        self.height = height
        self.weight = weight
        self.benchMax = benchMax
        self.squatMax = squatMax
        self.DLMax = DLMax
        self.wilks = wilks
    }
    
}

