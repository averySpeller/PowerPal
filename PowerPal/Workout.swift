//
//  Workout.swift
//  PowerPal
//
//  Created by Avery Speller on 2018-03-26.
//  Copyright © 2018 Avery Speller. All rights reserved.
//

import Foundation

class Workout{
    
    var id: Int
    var week: Int
    var day_week: Int
    var exercise_name: String
    var set: Int
    var reps: Int
    var weight: Double
    
    init(id: Int, week: Int, day_week: Int, exercise_name: String, set: Int, reps: Int, weight: Double){
        
        self.id = id
        self.week = week
        self.day_week = day_week
        self.exercise_name = exercise_name
        self.set = set
        self.reps = reps
        self.weight = weight
    }
    
}
