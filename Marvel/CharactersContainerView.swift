//
//  CharactersContainerView.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

class CharactersContainerView: UIView {
        
    let searchBar = AppSearchBar()
    
    let charactersTable = CharactersTable()
    
    let charactersCollection = CharactersCollection()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildViewHierarchy()
        self.setupConstraints()
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CharactersContainerView: ViewConfiguration {
    func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self).offset(64)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(44)
        }
        
        charactersTable.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
        charactersCollection.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    func buildViewHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(charactersTable)
        self.addSubview(charactersCollection)
    }
    
    func configureViews(){
        self.backgroundColor = ColorPalette.black
    }
}
