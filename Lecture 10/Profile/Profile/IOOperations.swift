//
//  IOOperations.swift
//  Profile
//
//  Created by Artemiy Sobolev on 01/03/2017.
//  Copyright © 2017 mipt. All rights reserved.
//

import Foundation

class ReadOperation<ObjectType: NSCoding>: Operation {
    
    let url: URL
    let handler: (ObjectType) -> Void
    
    init(url: URL, handler: @escaping (ObjectType) -> Void) {
        self.url = url; self.handler = handler
    }
    
    override func main() {
        
        guard !isCancelled else {
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        guard let object = NSKeyedUnarchiver.unarchiveObject(with: data) as? ObjectType else {
            return
        }
        
        handler(object)
    }
    
}

class WriteOperation<ObjectType: NSCoding>: Operation {
    let url: URL
    let object: ObjectType
    init(url: URL, object: ObjectType) {
        self.url = url; self.object = object
    }
    
    override func main() {
        
        guard !isCancelled else {
            return
        }
        
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        try? data.write(to: url)
        
    }
    
}

