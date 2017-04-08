//
//  Character.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

struct Character {
    var id: Int = 0
    var name: String = ""
    var bio: String = ""
    var thumImage: ThumbImage?
}


extension Character: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id    <- map["id"]
        name    <- map["name"]
        bio     <- map["description"]
        thumImage    <- map["thumbnail"]
    }
}

extension Character: Equatable {
    static func ==(lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Character: IdentifiableType {
    var identity : Int {
        return id
    }
}
