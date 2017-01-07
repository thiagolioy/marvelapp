//
//  CharactersCollectionDatasourceSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 07/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class CollectionDelegateMock: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
}

class CharactersCollectionDatasourceSpec: QuickSpec {
    override func spec() {
        describe("a Characters Collection Datasource  ") {
            var datasource: CharactersCollectionDatasource!
            var character: Marvel.Character!
            var collection: UICollectionView!
            
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file: "character", in: testBundle)
                character = mockLoader?.map(to: Character.self)
                
                let frame = CGRect(x: 0, y: 0, width: 300, height: 500)
                collection = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
                
                datasource = CharactersCollectionDatasource(items: [character!], collectionView: collection, delegate: CollectionDelegateMock())
            }
            
            it("should have a valid datasource") {
                expect(datasource).toNot(beNil())
            }
            
            it("should have the expected number of items") {
                let count = datasource.collectionView(collection, numberOfItemsInSection: 0)
                expect(count).to(equal(1))
            }
            
            it("should have be able to update items") {
                datasource.updateItems([character!,character!,character!])
                let count = datasource.collectionView(collection, numberOfItemsInSection: 0)
                expect(count).to(equal(3))
            }
            
            it("should return the expected cell") {
                let cell = datasource.collectionView(collection, cellForItemAt: IndexPath(row:0, section:0))
                expect(cell).to(beAKindOf(CharacterCollectionCell.self))
            }
            
        }
    }
}
