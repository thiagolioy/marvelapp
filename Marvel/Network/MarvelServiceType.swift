//
//  MarvelServiceType.swift
//  Marvel
//
//  Created by Thiago Lioy on 08/04/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
import RxSwift

enum Result<T> {
    case loading
    case success(T)
    case error(Swift.Error)
}

protocol MarvelServiceType {
    @discardableResult
    func characters(query: String?) -> Observable<Result<[Character]>>
}
