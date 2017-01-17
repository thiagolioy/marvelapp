//
//  RealmManager.swift
//  Marvel
//
//  Created by Thiago Lioy on 17/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import RealmSwift

class FavoriteCharacter: Object {
    dynamic var id = 0
    dynamic var isFavorite = true
    
    convenience init(character: Character) {
        self.init()
        id = character.id
    }
}

struct RealmManager {
    
    func isFavorite(character: Character, completion: @escaping (Bool) -> Void) {
        DispatchQueue(label: "background").async {
            let realm = try? Realm()
            let count = realm?.objects(FavoriteCharacter.self)
                .filter("id == \(character.id)").count ?? 0
            completion(count > 0)
        }
    }
    
    func favorite(character: Character) {
        DispatchQueue(label: "background").async {
            let favorite = FavoriteCharacter(character: character)
            let realm = try? Realm()
            try? realm?.write {
                realm?.add(favorite)
            }
        }
    }
    
    func unfavorite(character: Character) {
        DispatchQueue(label: "background").async {
            let realm = try? Realm()
            if let obj = realm?.objects(FavoriteCharacter.self)
                .filter("id == \(character.id)").first {
                try? realm?.write {
                    realm?.delete(obj)
                }
            }
        }
    }
    
}
