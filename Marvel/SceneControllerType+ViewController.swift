//
//  SceneControllerType+ViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 19/04/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit

extension SceneControllerType where Self: UIViewController {
    
    fileprivate func shouldSetupBackNavigation() -> Bool {
        guard let navigation = self.navigationController else {
            return false
        }
        
        guard let selfIndex = navigation.viewControllers.index(of: self) else {
            return false
        }
        
        let stackCount = navigation.viewControllers.count
        return selfIndex == (stackCount - 1)
    }
    
    func setupBackNavigation() {
        guard shouldSetupBackNavigation() else {
            return
        }
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem
            .backButton(action: viewModel.backAction())
    }
}
