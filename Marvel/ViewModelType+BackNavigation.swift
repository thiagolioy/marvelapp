//
//  ViewModelType+BackNavigation.swift
//  Marvel
//
//  Created by Thiago Lioy on 19/04/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
import Action
import RxSwift

extension ViewModelType {
    func backAction() -> CocoaAction {
        return CocoaAction {
            self.coordinator.pop()
            return Observable.empty()
        }
    }
}
