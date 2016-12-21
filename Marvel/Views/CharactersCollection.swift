//
//  CharactersCollection.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharactersCollection: UICollectionView {
    
    var didSelectCharacter: ((Character) -> Void)?
    
    fileprivate var customDatasource: CharactersCollectionDatasource?
    fileprivate var customDelegate: CharactersCollectionDelegate?
    
    convenience init() {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        customDelegate = CharactersCollectionDelegate(self)
        customDatasource = CharactersCollectionDatasource(items: [], collectionView: self, delegate: customDelegate!)
        self.backgroundColor = ColorPalette.black
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CharactersCollection {
    func updateItems(_ items: [Character]) {
        customDatasource?.updateItems(items)
    }
}


extension CharactersCollection: CharactersDelegate {
    func didSelectCharacter(at index: IndexPath) {
        if let char = customDatasource?.items[index.row] {
            didSelectCharacter?(char)
        }
    }
}
