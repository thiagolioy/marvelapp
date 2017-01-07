//
//  CharactersTableSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 07/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class CharactersTableSpec: QuickSpec {
    override func spec() {
        describe("a Characters Table ") {
            var table: CharactersTable!
            var character: Marvel.Character!
            
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file: "character", in: testBundle)
                character = mockLoader?.map(to: Character.self)
                
                table = CharactersTable()
            }
            
            it("should be able to update the collection") {
                table.updateItems([character!])
                let itemsCount = table.numberOfRows(inSection: 0)
                expect(itemsCount).to(equal(1))
            }
            
            context("valid callback") {
                it("should trigger did select for valid callback") {
                    table.updateItems([character!])
                    table.didSelectCharacter = { char in
                        expect(char.id).to(equal(character!.id))
                    }
                    let firstIndex = IndexPath(item: 0, section: 0)
                    table.didSelectCharacter(at: firstIndex)
                }
            }
            
            context("nil callback") {
                it("should not trigger did select for invalid callback") {
                    table.updateItems([character!])
                    let firstIndex = IndexPath(item: 0, section: 0)
                    
                    expect { () -> Void in
                        table.didSelectCharacter(at: firstIndex)
                        }.toNot(throwAssertion())
                }
            }
            
            it("should trigger fatal error if init with coder") {
                expect { () -> Void in
                    let _ = CharactersTable(coder: NSCoder())
                    }.to(throwAssertion())
            }
            
            context("invalid index Path") {
                it("should not throw exception for invalid index path") {
                    table.updateItems([character!])
                    let firstIndex = IndexPath(item: 3, section: 0)
                    
                    expect { () -> Void in
                        table.didSelectCharacter(at: firstIndex)
                        }.toNot(throwAssertion())
                }
                
                it("should not throw exception for invalid index path even if datasource is nil") {
                    table.dataSource = nil
                    let firstIndex = IndexPath(item: 3, section: 0)
                    
                    expect { () -> Void in
                        table.didSelectCharacter(at: firstIndex)
                        }.toNot(throwAssertion())
                }
            }
            
            
        }
    }
}

