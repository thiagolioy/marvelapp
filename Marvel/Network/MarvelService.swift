//
//  MarvelAPIManager.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Moya_ObjectMapper



struct MarvelService: MarvelServiceType {
    
    let provider = RxMoyaProvider<MarvelAPI>()
    let disposeBag = DisposeBag()
    
    func characters(query: String? = nil) -> Observable<[Character]> {
        return provider.request(.characters(query))
                .map{ $0.removeAPIWrappers() }
                .mapArray(Character.self)
                .asObservable()
    }
    
}
