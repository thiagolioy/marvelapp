//
//  CharacterFavoriteView.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit
import RxSwift
import ReSwift

class CharacterFavoriteView: FavoriteView, StoreSubscriber {

    var character: Character?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        store.subscribe(self) { state in
            state.favoritesState
        }
    }
    
    
    deinit {
        store.unsubscribe(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toogleFavoriteState(for favorites: [FavoriteCharacter]) {
        let isFavorite = favorites.contains { [weak self] favorite in
            favorite.id == self?.character?.id
        }
        
        if isFavorite {
            self.viewState = .favourited
        } else {
            self.viewState = .notFavourited
        }
    }
    
    func newState(state: FavoritesState) {
        toogleFavoriteState(for: state.favorites)
    }
    
    func setup(with character: Character) {
        
        self.character = character
        
        toogleFavoriteState(for: store.state.favoritesState.favorites)

        didFavorite = {
            store.dispatch(FavoriteAction(character: character))
        }
        
        didUnfavorite = {
            store.dispatch(UnfavoriteAction(character: character))
        }
    }
}
