//
//  ModelController.swift
//  TTUNotes
//
//  Created by Anastasiia Soboleva on 08.03.17.
//  Copyright © 2017 Anastasiia Soboleva. All rights reserved.
//

import Foundation
import CoreData

private var isLoaded = false
private let container = NSPersistentContainer(name: "Model")

//This is a good async way to initialise a Core Data stack and load a persistence store

extension NSPersistentContainer {
    
    static func notesContainer(errorHandler eh: @escaping (Error) -> Void, complationHanlder ch: @escaping (NSPersistentContainer) -> Void) {
        
        assert(Thread.isMainThread)
        
        guard !isLoaded else {
            return ch(container)
        }
        
        let group = DispatchGroup()
        
        container.persistentStoreDescriptions.forEach {
            $0.shouldAddStoreAsynchronously = true
            group.enter()
        }
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let err = error {
                return eh(err)
            }
            
            group.leave()
            
        })
        
        group.notify(queue: .main) {
            container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
            isLoaded = true
            ch(container)
        }
        
    }
}

