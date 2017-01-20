//
//  CharacterFavoriteView.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit
import RxSwift

class CharacterFavoriteView: FavoriteView {

    var disposeBag: DisposeBag?
    let realmManager = RealmManager()
    var character: Character?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with character: Character) {
        let disposeBag = DisposeBag()
        
        self.character = character
        
        self.viewState = .notFavourited
        realmManager.isFavorite(character: character)
            .subscribe(onNext: { [weak self] (result) in
                if result.count > 0 {
                    self?.viewState = .favourited
                } else {
                    self?.viewState = .notFavourited
                }
            }).addDisposableTo(disposeBag)
        
        self.disposeBag = disposeBag
        
        didFavorite = { [weak self] in
            self?.realmManager.favorite(character: character)
        }
        
        didUnfavorite = { [weak self] in
            self?.realmManager.unfavorite(character: character)
        }
    }
}
