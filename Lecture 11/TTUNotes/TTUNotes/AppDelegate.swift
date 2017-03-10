//
//  AppDelegate.swift
//  TTUNotes
//
//  Created by Anastasiia Soboleva on 08.03.17.
//  Copyright © 2017 Anastasiia Soboleva. All rights reserved.
//

import UIKit
import CoreData

private let sharedContainer = NSPersistentContainer(name: "Model")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		sharedContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        sharedContainer.loadPersistentStores { _ in
        }
        return true
    }

}

extension UIViewController {
    var container: NSPersistentContainer {
        return sharedContainer
    }
}

