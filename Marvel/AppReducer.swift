//
//  AppReducer.swift
//  Marvel
//
//  Created by Thiago Lioy on 25/01/17.
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
