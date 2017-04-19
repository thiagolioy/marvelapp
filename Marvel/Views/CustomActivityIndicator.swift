//
//  CustomActivityIndicator.swift
//  Marvel
//
//  Created by Thiago Lioy on 19/04/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit
import RxSwift
import NSObject_Rx

class CustomActivityIndicator: UIActivityIndicatorView {
    
     convenience init() {
        self.init(frame: .zero)
        setupStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomActivityIndicator {
    fileprivate func setupStyle() {
        hidesWhenStopped = true
        tintColor = ColorPalette.white
    }
    
    func bindLoadingState<T>(for observable: Observable<Result<T>>) {
        observable
            .subscribe(setupState())
            .addDisposableTo(rx_disposeBag)
    }
    
    fileprivate func setupState<T>() -> PublishSubject<Result<T>> {
        let subject = PublishSubject<Result<T>>()
        subject.subscribe(onNext: { [unowned self] result in
            
            switch result {
            case .loading:
                self.isHidden = false
                self.startAnimating()
            default:
                self.stopAnimating()
            }
            
        }).addDisposableTo(rx_disposeBag)
        return subject
    }
    
}
