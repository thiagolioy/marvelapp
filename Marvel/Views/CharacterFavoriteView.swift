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
    var character: Character?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addNotifications()
    }
    
    deinit {
        removeNotifications()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with character: Character) {
        self.character = character
        
        self.viewState = .notFavourited
        realmManager.isFavorite(character: character)
            .subscribe(onNext: { [weak self] _ in
                self?.viewState = .favourited
            }).dispose()
        
        didFavorite = { [weak self] in
            self?.realmManager.favorite(character: character)
            self?.postFavoriteStatusChangedNotification()
        }
        
        didUnfavorite = { [weak self] in
            self?.realmManager.unfavorite(character: character)
            self?.postFavoriteStatusChangedNotification()
        }
    }
    
    func favoriteStatusChanged() {
        if let character = character {
            self.viewState = .notFavourited
            realmManager.isFavorite(character: character)
                .subscribe(onNext: { [weak self] _ in
                    self?.viewState = .favourited
                }).dispose()
        }
    }
    
}

extension CharacterFavoriteView {
    fileprivate func removeNotifications() {
        NotificationCenter.default.removeObserver(target, name: NSNotification.Name(rawValue: "FavoriteStatusChanged"), object: nil)
    }
    
    fileprivate func postFavoriteStatusChangedNotification() {
        NotificationCenter.default.post(name: Notification.Name("FavoriteStatusChanged"), object: nil)
    }
    
    fileprivate func addNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favoriteStatusChanged),
            name: NSNotification.Name(rawValue: "FavoriteStatusChanged"),
            object: nil)
    }
}
