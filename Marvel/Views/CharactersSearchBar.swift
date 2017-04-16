//
//  CharactersSearchBar.swift
//  Marvel
//
//  Created by Thiago Lioy on 16/04/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

typealias SearchCallback = (String) -> Void

class CharactersSearchBar: UISearchBar {
    
    var searchCallback: SearchCallback?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        setupSearchBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStyle() {
        showsCancelButton = true
        searchBarStyle = .minimal
    }
    
    func setupSearchBar() {
        
        let processSearchObservable = self.rx.searchButtonClicked
            .shareReplay(1)
        
        processSearchObservable
            .map{self.text ?? ""}
            .filter{ !$0.isEmpty }
            .subscribe(onNext: { [weak self] query in
                self?.searchCallback?(query)
            }).addDisposableTo(rx_disposeBag)
        
        let cancelSearchObservable = self.rx.cancelButtonClicked
            .asObservable()
        
        Observable.merge([processSearchObservable, cancelSearchObservable])
            .subscribe(endEditingSearchBar())
            .addDisposableTo(rx_disposeBag)
        
    }
    
    func endEditingSearchBar() -> PublishSubject<Void> {
        let subject = PublishSubject<Void>()
        subject.subscribe(onNext: { [unowned self] _ in
            self.text = ""
            self.endEditing(true)
        }).addDisposableTo(rx_disposeBag)
        return subject
    }
    
    
}
