//
//  Recipe.swift
//  Recipes
//
//  Created by Artemiy Sobolev on 08/02/2017.
//  Copyright © 2017 Artemiy Sobolev. All rights reserved.
//

import Foundation

class Recipe: NSObject, NSCoding  {
    
    let name: String
    let type: FoodType
    var starred: Bool = false
    
    override var description: String {
        return type.rawValue
    }
    
    enum FoodType: String {
        case main, desert, soup
    }
    
    init(named: String, foodType: FoodType = .main) {
        name = named; type = foodType
    }
    
    enum CodingKeys: String {
        case name, star, type
    }
    
    //MARK: - NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(starred, forKey: CodingKeys.star.rawValue)
        aCoder.encode(name, forKey: CodingKeys.name.rawValue)
        aCoder.encode(type.rawValue, forKey: CodingKeys.type.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: CodingKeys.name.rawValue) as? String, let typeString = aDecoder.decodeObject(forKey: CodingKeys.type.rawValue) as? String, let type = FoodType(rawValue: typeString) else {
            return nil
        }
        self.init(named: name, foodType: type)
        starred = aDecoder.decodeBool(forKey: CodingKeys.star.rawValue)
        
    }
    
}
