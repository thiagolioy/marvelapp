//
//  CharactersCollectionDatasource.swift
//  Marvel
//
//  Created by Thiago Lioy on 20/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharactersCollectionDatasource: NSObject, ItemsCollectionViewDatasource {
    
    var items:[Character] = []
    weak var collectionView: UICollectionView?
    weak var delegate: UICollectionViewDelegate?
    
    required init(items: [Character], collectionView: UICollectionView, delegate: UICollectionViewDelegate) {
        self.items = items
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
        collectionView.register(cellType: CharacterCollectionCell.self)
        self.setupCollectionView()
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CharacterCollectionCell.self)
        let character = self.items[indexPath.row]
        cell.setup(item: character)
        return cell
    }
}

class CharactersCollectionDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let delegate: CharactersDelegate
    
    init(_ delegate: CharactersDelegate) {
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelectCharacter(at: indexPath.row)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        return CharacterCollectionCell.size(for: width)
    }
}
