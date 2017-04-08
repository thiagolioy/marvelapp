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
        ApperanceProxyHelper.customizeApp()
        setupWindowForViewCode()
        setupInitialCoordinator()
        return true
    }
    
    func setupWindowForViewCode() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
    }
    
    func setupInitialCoordinator() {
        let sceneCoordinator = SceneCoordinator(window: window!)
        let viewModel = CharactersViewModel(marvelService: MarvelService(),
                                            coordinator: sceneCoordinator)
        let firstScene = Scene.characters(viewModel)
        sceneCoordinator.transition(to: firstScene, type: .root)
    }


}

