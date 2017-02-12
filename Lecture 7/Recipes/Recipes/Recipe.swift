//
//  Recipe.swift
//  Recipes
//
//  Created by Artemiy Sobolev on 08/02/2017.
//  Copyright © 2017 Artemiy Sobolev. All rights reserved.
//

import Foundation

class Recipe {
    
    let name: String
    let type: FoodType
    var starred: Bool = false
    
    var description: String {
        return type.rawValue
    }
    
    enum FoodType: String {
        case main, desert, soup
    }
    
    init(named: String, foodType: FoodType = .main) {
        name = named; type = foodType
    }
    
    
}
