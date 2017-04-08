//
//  ApperanceProxyHelper.swift
//  Marvel
//
//  Created by Thiago Lioy on 11/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import UIKit

struct ApperanceProxyHelper {
    
    static func customizeApp() {
        customizeSearchBar()
        customizeNavigationBar()
    }
    
    static func customizeSearchBar() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf:
            [UISearchBar.self]).tintColor = ColorPalette.white
    }
    
    static func customizeNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = ColorPalette.white
        navigationBarAppearace.barTintColor = ColorPalette.red
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:ColorPalette.white]
    }
    
}


