//
//  AppDelegate.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ApperanceProxyHelper.customizeNavigationBar()
        ApperanceProxyHelper.customizeSearchBar()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        let navController = UINavigationController(rootViewController: CharactersViewController(apiManager: MarvelAPIManager()))
        self.window?.rootViewController = navController
        
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

