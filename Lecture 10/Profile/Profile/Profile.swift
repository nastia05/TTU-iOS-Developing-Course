//
//  Profile.swift
//  Profile
//
//  Created by Artemiy Sobolev on 01/03/2017.
//  Copyright © 2017 mipt. All rights reserved.
//

import Foundation

class Profile: NSObject, NSCoding {
    let identifier: String
    let email: String
    
    enum CodingKey: String {
        case identifier, email
    }
    
    init(identifier: String, email: String) {
        self.identifier = identifier; self.email = email
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard  let identifier = aDecoder.decodeObject(forKey: CodingKey.identifier.rawValue) as? String,
            let email = aDecoder.decodeObject(forKey: CodingKey.email.rawValue) as? String else {
                return nil
        }
        
        self.identifier = identifier; self.email = email
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(identifier, forKey: CodingKey.identifier.rawValue)
        aCoder.encode(email, forKey: CodingKey.email.rawValue)
    }
    
}
