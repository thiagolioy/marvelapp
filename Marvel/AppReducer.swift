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
    let apiManager = MarvelAPIManager()
    
    func handleAction(action: Action, state: AppState?) -> AppState {
        return AppState(
            favoritesState: FavoriteReducer().handleAction(action: action, state: state?.favoritesState),
            fetchedCharactersState: FetchedCharactersReducer(apiManager: apiManager)
                .handleAction(action: action, state: state?.fetchedCharactersState)
        )
    }
    
}

struct FetchedCharactersReducer: Reducer {

    let apiManager: MarvelAPICalls
    
    init(apiManager: MarvelAPICalls) {
        self.apiManager = apiManager
    }
    
    func handleAction(action: Action, state: FetchedCharactersState?) -> FetchedCharactersState {
        switch action {
        case let action as FetchCharactersAction:
            apiManager.characters(query: action.query) { characters in
                DispatchQueue.main.async {
                    store.dispatch(SetCharactersAction(characters: characters ?? []))
                }
            }
            break
        case let action as SetCharactersAction:
            return FetchedCharactersState(requestState: .finished,
                                            characters: action.characters)
        default:
            break
        }
        return FetchedCharactersState(requestState: .loading,
                                               characters: [])
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
