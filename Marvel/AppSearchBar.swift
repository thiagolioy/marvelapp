//
//  AppSearchBar.swift
//  Marvel
//
//  Created by Thiago Lioy on 21/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

class AppSearchBar: UISearchBar {
    
    var doSearch: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        customizeStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customizeStyle() {
        self.showsCancelButton = true
        self.searchBarStyle = .minimal
    }
}

extension AppSearchBar: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query = searchBar.text ?? ""
        if !query.isEmpty {
            doSearch?(query)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
