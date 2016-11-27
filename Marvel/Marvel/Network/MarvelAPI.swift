//
//  MarvelAPI.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import Moya
import CryptoSwift
import Dollar
import Keys

fileprivate struct MarvelAPIConfig {
    fileprivate static let keys = MarvelKeys()
    static let privatekey = keys.marvelPrivateKey()!
    static let apikey = keys.marvelApiKey()!
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(privatekey)\(apikey)".md5()
}

enum MarvelAPI {
    case characters(String?)
    case character(String)
}

extension MarvelAPI: TargetType {
    var baseURL: URL { return URL(string: "https://gateway.marvel.com:443")! }
    
    
    var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        case .character(let characterId):
            return "/v1/public/characters/\(characterId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .characters, .character:
            return .get
        }
    }
    
    func authParameters() -> [String: String] {
        return ["apikey": MarvelAPIConfig.apikey,
                "ts": MarvelAPIConfig.ts,
                "hash": MarvelAPIConfig.hash]
    }
    
    var parameters: [String: Any]? {
        
        switch self {
        
        case .characters(let query):
            if let query = query {
                return $.merge(authParameters(),
                               ["nameStartsWith": query])
            }
            return authParameters()
            
        case .character(let characterId):
            return $.merge(authParameters(),
                           ["characterId": characterId])
        }
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
}
