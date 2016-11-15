//
//  Character.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import ObjectMapper


struct ThumbImage {
    var path: String = ""
    var imageExtension: String = ""
}

extension ThumbImage: Mappable {
    init?(map: Map) {
    
    }
    
    mutating func mapping(map: Map) {
        path    <- map["path"]
        imageExtension    <- map["extension"]
    }
}

struct Character {
    var id: Int = 0
    var name: String = ""
    var thumImage: ThumbImage?
}

extension Character: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id    <- map["id"]
        name    <- map["name"]
        thumImage    <- map["thumbnail"]
    }
}
