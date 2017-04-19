//
//  UIBarButtonItem+BackButton.swift
//  Marvel
//
//  Created by Thiago Lioy on 19/04/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit
import Action

extension UIBarButtonItem {
    class func backButton(action: CocoaAction) -> UIBarButtonItem {
        var customBackButton = UIBarButtonItem(title: "", style: .done,
                                               target: nil, action: nil)
        customBackButton.icon(from: .FontAwesome, code: "chevron-left", ofSize: 20)
        customBackButton.rx.action = action
        return customBackButton
    }
}
