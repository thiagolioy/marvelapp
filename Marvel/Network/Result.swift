//
//  Result.swift
//  Marvel
//
//  Created by Thiago Lioy on 19/04/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation

enum Result<T> {
    case loading
    case success(T)
    case error(Swift.Error)
    
    func unwrap() -> T? {
        if case Result<T>.success(let result) = self {
            return result
        }
        return nil
    }

}
