//
//  AppReducer.swift
//  Marvel
//
//  Created by Thiago Lioy on 24/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
import ReSwift

struct AppReducer: Reducer {
    
    func handleAction(action: Action, state: AppState?) -> AppState {
        return AppState(
            favoritesState: FavoriteReducer().handleAction(action: action, state: state?.favoritesState)
        )
    }
    
}

struct FavoriteReducer: Reducer {
    
    func handleAction(action: Action, state: FavoritesState?) -> FavoritesState {
        let realmManager = RealmManager()
        switch action {
        case let action as FavoriteAction:
            realmManager.favorite(character: action.character)
            break
        case let action as UnfavoriteAction:
            realmManager.unfavorite(character: action.character)
            break
        default:
            break
        }
        return FavoritesState(favorites: realmManager.favorites())
    }
    
}
