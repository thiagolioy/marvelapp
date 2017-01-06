//
//  CharacterCollectionCellSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 06/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class CharacterCollectionCellSpec: QuickSpec {
    override func spec() {
        describe("a Character Collection Cell ") {
            var cell: Marvel.CharacterCollectionCell!
            var character: Marvel.Character!
            
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file: "character", in: testBundle)
                character = mockLoader?.map(to: Character.self)
                
                cell = CharacterCollectionCell(frame: .zero)
                
                cell.setup(item: character)
            }
            
            it("should not be nil") {
                expect(cell).toNot(beNil())
                expect(cell.gridView).toNot(beNil())
            }
            
            it("should have expected size") {
                let cellSize = CharacterCollectionCell.size(for: 200.0)
                expect(cellSize.height).to(equal(100))
                expect(cellSize.width).to(equal(100))
            }
            
            it("should trigger fatal error if init with coder") {
                expect { () -> Void in
                    let _ = CharacterCollectionCell(coder: NSCoder())
                    }.to(throwAssertion())
            }
            
        }
    }
}
