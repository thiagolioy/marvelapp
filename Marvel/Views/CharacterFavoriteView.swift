//
//  CharacterFavoriteView.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit
import RxSwift
import NSObject_Rx

class CharacterFavoriteView: FavoriteView {

    let realmManager = RealmManager()
    var character: Character?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with character: Character) {
        self.character = character
        
        realmManager.isFavorite(character: character)
            .map { $0.count > 0}
            .startWith(false)
            .subscribe(onNext: { [weak self] result in
                self?.viewState = result ?
                    .favourited : .notFavourited
            }).addDisposableTo(rx_disposeBag)
        
        didFavorite = { [weak self] in
            self?.realmManager.favorite(character: character)
        }
        
        didUnfavorite = { [weak self] in
            self?.realmManager.unfavorite(character: character)
        }
    }
}
