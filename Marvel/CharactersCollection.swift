//
//  CharactersCollection.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharactersCollection: UIView {
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let tb = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tb.backgroundColor = ColorPalette.black
        return tb
    }()
    
    
    
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

extension CharactersCollection: ViewConfiguration {
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    func buildViewHierarchy() {
        self.addSubview(collectionView)
    }
    
    func configureViews(){
        self.backgroundColor = ColorPalette.black
    }
}

