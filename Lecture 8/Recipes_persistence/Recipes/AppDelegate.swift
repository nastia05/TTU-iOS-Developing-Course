//
//  AppDelegate.swift
//  Recipes
//
//  Created by Artemiy Sobolev on 08/02/2017.
//  Copyright © 2017 Artemiy Sobolev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //MARK: - save a value to User Defaults
        UserDefaults.standard.set(true, forKey: "ApplicationLaunched")
        
        return true
    }


}

