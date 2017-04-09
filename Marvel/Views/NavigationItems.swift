//
//  NavigationItemsFactory.swift
//  Marvel
//
//  Created by Thiago Lioy on 21/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Action

extension UIBarButtonItem {
    convenience init(image: UIImage?, style: UIBarButtonItemStyle) {
        self.init(image: image, style: style, target: nil, action: nil)
    }
}

enum NavigationItems {
    case list(CocoaAction)
    case grid(CocoaAction)
    
    func button() -> UIBarButtonItem {
        switch self {
        case .list(let action):
            var buttomItem = UIBarButtonItem(image: ImageAssets.listIcon.image, style: .plain)
            buttomItem.rx.action = action
            return buttomItem
        case .grid(let action):
            var buttomItem = UIBarButtonItem(image: ImageAssets.gridIcon.image, style: .plain)
            buttomItem.rx.action = action
            return buttomItem
        }
    }
}
