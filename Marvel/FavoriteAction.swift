//
//  FavoriteAction.swift
//  Marvel
//
//  Created by Thiago Lioy on 24/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
import ReSwift

struct FavoriteAction: Action {
    let character: Character
}

struct UnfavoriteAction: Action {
    let character: Character
}
