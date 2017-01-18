//
//  CharacterFavoriteView.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit

class CharacterFavoriteView: FavoriteView {

    let realmManager = RealmManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with character: Character) {
        realmManager.isFavorite(character: character)
            .subscribe(onNext: { [weak self] _ in
                self?.viewState = .favourited
            }).dispose()
        
        
        didFavorite = { [weak self] in
            self?.realmManager.favorite(character: character)
        }
        
        didUnfavorite = { [weak self] in
            self?.realmManager.unfavorite(character: character)
        }
    }
    
}
