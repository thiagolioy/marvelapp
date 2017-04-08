//
//  Navigation.swift
//  Marvel
//
//  Created by Thiago Lioy on 08/04/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxNavigationControllerDelegateProxy: DelegateProxy, DelegateProxyType, UINavigationControllerDelegate {
    
    static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        guard let navigationController = object as? UINavigationController else {
            fatalError()
        }
        return navigationController.delegate
    }
    
    static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        guard let navigationController = object as? UINavigationController else {
            fatalError()
        }
        if delegate == nil {
            navigationController.delegate = nil
        } else {
            guard let delegate = delegate as? UINavigationControllerDelegate else {
                fatalError()
            }
            navigationController.delegate = delegate
        }
    }
}

extension Reactive where Base: UINavigationController {
    /**
     Reactive wrapper for `delegate`.
     For more information take a look at `DelegateProxyType` protocol documentation.
     */
    public var delegate: DelegateProxy {
        return RxNavigationControllerDelegateProxy.proxyForObject(base)
    }
}

