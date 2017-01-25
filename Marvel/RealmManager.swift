//
//  RealmManager.swift
//  Marvel
//
//  Created by Thiago Lioy on 17/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import RealmSwift
import RxSwift
import RxRealm

class FavoriteCharacter: Object {
    dynamic var id = 0
    dynamic var isFavorite = true
    
    convenience init(character: Character) {
        self.init()
        id = character.id
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

struct RealmManager {
    
    let disposeBag = DisposeBag()
    
    func isFavorite(character: Character) -> [FavoriteCharacter] {
        return favorites(filter: "id == \(character.id)")
    }
    
    func favorite(character: Character) {
        let favorite = FavoriteCharacter(character: character)
        Observable.just(favorite)
            .subscribe(Realm.rx.add())
            .addDisposableTo(disposeBag)
    }
    
    private func _favorites(filter predicateFormat: String? = nil) -> Results<FavoriteCharacter>?{
        guard let realm = try? Realm() else {
            return nil
        }
        var results: Results<FavoriteCharacter> = realm.objects(FavoriteCharacter.self)
        if let predicate = predicateFormat {
            results = results.filter(predicate)
        }
        return results
    }
    
    func favorites(filter predicateFormat: String? = nil) -> [FavoriteCharacter] {
        if let results = _favorites(filter: predicateFormat) {
            return Array(results)
        } else {
            return []
        }
    }
    
    func unfavorite(character: Character) {
        if let results = _favorites(filter: "id == \(character.id)") {
            Observable.collection(from: results)
                .subscribe(Realm.rx.delete())
                .dispose()
        }
    }
    
}
