//
//  MarvelServiceType.swift
//  Marvel
//
//  Created by Thiago Lioy on 08/04/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
import RxSwift

protocol MarvelServiceType {
    @discardableResult
    func characters(query: String?) -> Observable<[Character]>
}
