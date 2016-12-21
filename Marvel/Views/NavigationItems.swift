//
//  NavigationItemsFactory.swift
//  Marvel
//
//  Created by Thiago Lioy on 21/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

enum NavigationItems {
    case list(Any, Selector)
    case grid(Any, Selector)
    
    func button() -> UIBarButtonItem {
        switch self {
        case .list(let target, let selector):
            return UIBarButtonItem(image: UIImage(named: "List Icon"), style: .plain, target: target, action: selector)
        case .grid(let target, let selector):
            return UIBarButtonItem(image: UIImage(named: "Grid Icon"), style: .plain, target: target, action: selector)
        }
    }
}
