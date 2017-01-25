//
//  AppState.swift
//  Marvel
//
//  Created by Thiago Lioy on 24/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
import ReSwift
import RealmSwift
import RxSwift
import RxRealm

struct AppState: StateType {
    var favoritesState: FavoritesState
}

struct FavoritesState: StateType {
    var favorites: [FavoriteCharacter] = []
}
