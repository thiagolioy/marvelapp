//
//  NewTestSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 26/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class CharacterSpec: QuickSpec {
    override func spec() {
        describe("a character") {
            
            var character: Marvel.Character!
            
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file: "character", in: testBundle)
                character = mockLoader?.map(to: Character.self)
            }
            
            it("should be able to create a chracter from json") {
                expect(character).toNot(beNil())
            }
            
            it("should have a thumbImage") {
                expect(character.thumImage).toNot(beNil())
            }
            
        }
    }
}
