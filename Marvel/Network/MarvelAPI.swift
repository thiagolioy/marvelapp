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
import Alamofire

fileprivate struct MarvelAPIConfig {
    fileprivate static let keys = MarvelKeys()
    static let privatekey = keys.marvelPrivateKey
    static let apikey = keys.marvelApiKey
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(privatekey)\(apikey)".md5()
}

enum MarvelAPI {
    case characters(String?)
}

extension MarvelAPI: TargetType {
    var baseURL: URL { return URL(string: "https://gateway.marvel.com:443")! }
    
    
    var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .characters:
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
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding()
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
