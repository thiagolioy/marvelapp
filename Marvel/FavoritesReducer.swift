//
//  FavoritesReducer.swift
//  Marvel
//
//  Created by Thiago Lioy on 25/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
import ReSwift
struct FavoriteReducer: Reducer {
    
    func handleAction(action: Action, state: FavoritesState?) -> FavoritesState {
        let realmManager = RealmManager()
        switch action {
        case let action as FavoriteAction:
            realmManager.favorite(character: action.character)
        case let action as UnfavoriteAction:
            realmManager.unfavorite(character: action.character)
        default:
            break
        }
        return FavoritesState(favorites: realmManager.favorites())
    }
    
}
