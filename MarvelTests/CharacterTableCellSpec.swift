//
//  CharacterTableCellSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 06/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class CharacterTableCellSpec: QuickSpec {
    override func spec() {
        describe("a Character Table Cell ") {
            var cell: CharacterTableCell!
            var character: Marvel.Character!
            
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file: "character", in: testBundle)
                character = mockLoader?.map(to: Character.self)
                
                cell = CharacterTableCell(style: .default, reuseIdentifier:
                    "CharacterTableCell")
                
                cell.setup(item: character)
            }
            
            it("should not be nil") {
                expect(cell).toNot(beNil())
                expect(cell.characterRow).toNot(beNil())
            }
            
            it("should have expected height") {
                expect(CharacterTableCell.height()).to(equal(80))
            }
            
            it("should have expected background color") {
                expect(cell.contentView.backgroundColor).to(equal(ColorPalette.black))
            }
            
            it("should have expected selection style") {
                expect(cell.selectionStyle == .none).to(beTruthy())
            }
            
            it("should have expected name after setup") {
                expect(cell.characterRow.name.text).to(equal(character!.name))
            }
            
            it("should trigger fatal error if init with coder") {
                expect { () -> Void in
                    let _ = CharacterTableCell(coder: NSCoder())
                    }.to(throwAssertion())
            }
            
        }
    }
}
