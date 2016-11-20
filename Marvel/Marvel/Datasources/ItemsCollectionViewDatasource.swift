//
//  ItemsCollectionViewDatasource.swift
//  Marvel
//
//  Created by Thiago Lioy on 20/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

protocol ItemsCollectionViewDatasource: UICollectionViewDataSource {
    associatedtype T
    var items:[T] {get}
    weak var collectionView: UICollectionView? {get}
    weak var delegate: UICollectionViewDelegate? {get}
    
    init(items: [T], collectionView: UICollectionView, delegate: UICollectionViewDelegate)
    
    func setupCollectionView()
}

extension ItemsCollectionViewDatasource {
    func setupCollectionView() {
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self.delegate
        self.collectionView?.reloadData()
    }
}

