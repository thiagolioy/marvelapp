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
    
    static func customizeNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = ColorPalette.white
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:ColorPalette.white]
    }
    
}


