//
//  CharactersContainerView.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

class CharactersContainerView: UIView {
        
    let searchBar = CharactersSearchBar()
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.hidesWhenStopped = true
        ai.tintColor = ColorPalette.white
        return ai
    }()
    
    let charactersTable = CharactersTable()
    
    lazy var charactersCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //Find out a better way to do this!!
        let parentWidth = UIApplication.shared.windows.first!.bounds.width
        layout.itemSize = CharacterCollectionCell.size(for: parentWidth)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isHidden = true
        cv.backgroundColor = ColorPalette.black
        cv.register(cellType: CharacterCollectionCell.self)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
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
        activityIndicator.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
    }
    
    func buildViewHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(charactersTable)
        self.addSubview(charactersCollection)
        self.addSubview(activityIndicator)
    }
    
    func configureViews(){
        self.backgroundColor = ColorPalette.black
    }
}
