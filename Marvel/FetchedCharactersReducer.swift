//
//  FetchedCharactersReduces.swift
//  Marvel
//
//  Created by Thiago Lioy on 25/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
import ReSwift

struct FetchedCharactersReducer: Reducer {
    
    let apiManager: MarvelAPICalls
    
    func handleAction(action: Action, state: FetchedCharactersState?) -> FetchedCharactersState {
        switch action {
        case let action as FetchCharactersAction:
            fetchCharacters(query: action.query)
            break
        case let action as SetCharactersAction:
            return FetchedCharactersState(characters: Result.finished(action.characters))
        default:
            break
        }
        return state ?? FetchedCharactersState(characters: .loading)
    }
    
    func fetchCharacters(query: String?) {
        apiManager.characters(query: query) { characters in
            DispatchQueue.main.async {
                store.dispatch(SetCharactersAction(characters: characters ?? []))
            }
        }
    }
}
