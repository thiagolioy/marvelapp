//
//  CharactersCollectionSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 06/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class CharactersCollectionSpec: QuickSpec {
    override func spec() {
        describe("a Characters Collection ") {
            var collection: CharactersCollection!
            var character: Marvel.Character!
            
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file: "character", in: testBundle)
                character = mockLoader?.map(to: Character.self)
                
                collection = CharactersCollection()
            }
            
            it("should be able to update the collection") {
                collection.updateItems([character!])
                let itemsCount = collection.numberOfItems(inSection: 0)
                expect(itemsCount).to(equal(1))
            }
            
            context("valid callback") {
                it("should trigger did select for valid callback") {
                    collection.updateItems([character!])
                    collection.didSelectCharacter = { char in
                        expect(char.id).to(equal(character!.id))
                    }
                    let firstIndex = IndexPath(item: 0, section: 0)
                    collection.didSelectCharacter(at: firstIndex)
                }
            }
            
            context("nil callback") {
                it("should not trigger did select for invalid callback") {
                    collection.updateItems([character!])
                    let firstIndex = IndexPath(item: 0, section: 0)
                    
                    expect { () -> Void in
                        collection.didSelectCharacter(at: firstIndex)
                    }.toNot(throwAssertion())
                }
            }
            it("should trigger fatal error if init with coder") {
                expect { () -> Void in
                    let _ = CharactersCollection(coder: NSCoder())
                    }.to(throwAssertion())
            }
            
            context("invalid index Path") {
                it("should not throw exception for invalid index path") {
                    collection.updateItems([character!])
                    let firstIndex = IndexPath(item: 3, section: 0)
                    
                    expect { () -> Void in
                        collection.didSelectCharacter(at: firstIndex)
                        }.toNot(throwAssertion())
                }
                
                it("should not throw exception for invalid index path even if datasource is nil") {
                    collection.dataSource = nil
                    let firstIndex = IndexPath(item: 3, section: 0)
                    
                    expect { () -> Void in
                        collection.didSelectCharacter(at: firstIndex)
                        }.toNot(throwAssertion())
                }
            }
            
            
        }
    }
}
