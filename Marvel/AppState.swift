//
//  AppState.swift
//  Marvel
//
//  Created by Thiago Lioy on 24/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var favoritesState: FavoritesState
    var fetchedCharactersState: FetchedCharactersState
}

struct FavoritesState: StateType {
    var favorites: [FavoriteCharacter] = []
}

enum Result<T> {
    case loading
    case failed
    case finished(T)
}
struct FetchedCharactersState: StateType {
    var characters: Result<[Character]> = .loading
}
