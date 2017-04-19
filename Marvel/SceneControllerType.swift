//
//  SceneControllerType.swift
//  Marvel
//
//  Created by Thiago Lioy on 19/04/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
protocol SceneControllerType {
    associatedtype T: ViewModelType
    var viewModel: T {get}
    
    init(viewModel: T)
}
