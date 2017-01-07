//
//  CharactersCollectionDelegateSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 07/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class CharactersCollectionDelegateSpec: QuickSpec {
    override func spec() {
        
        describe("a Characters Collection Delegate") {
            var delegate: CharactersCollectionDelegate!
            var mock: CharactersDelegateMock!
            var collectionView: UICollectionView!
            
            beforeEach {
                mock = CharactersDelegateMock()
                delegate = CharactersCollectionDelegate(mock)
                let frame = CGRect(x: 0, y: 0, width: 300, height: 500)
                collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())

            }
            
            it("should have a cell of expected size") {
                let firstIndex = IndexPath(row: 0, section: 0)
                let size = delegate.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: firstIndex)
                expect(size.width).to(equal(150))
                expect(size.height).to(equal(150))
            }
            
            it("should trigger charactersDelegate") {
                mock.didTriggerDelegate = false
                let firstIndex = IndexPath(row: 0, section: 0)
                delegate.collectionView(collectionView, didSelectItemAt: firstIndex)
                expect(mock.didTriggerDelegate).to(beTruthy())
            }
        }
    }
}

