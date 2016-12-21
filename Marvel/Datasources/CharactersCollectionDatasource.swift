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
    
    func updateItems(_ items: [Character]) {
        self.items = items
        self.collectionView?.reloadData()
    }
}

class CharactersCollectionDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let delegate: CharactersDelegate
    
    init(_ delegate: CharactersDelegate) {
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelectCharacter(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        return CharacterCollectionCell.size(for: width)
    }
}
