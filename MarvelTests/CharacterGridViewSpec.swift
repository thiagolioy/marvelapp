//
//  CharacterGridViewSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 07/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class CharacterGridViewSpec: QuickSpec {
    override func spec() {
        describe("a Character Grid View ") {
            var container: CharacterGridView!
            
            beforeEach {
                container = CharacterGridView()
            }
            
            it("should trigger fatal error if init with coder") {
                expect { () -> Void in
                    let _ = CharacterGridView(coder: NSCoder())
                    }.to(throwAssertion())
            }
            
            it("should have expected number of subviews") {
                let subviews = container.subviews
                expect(subviews.count).to(equal(2))
            }
            
            it("should have expected subviews") {
                let subviews = container.subviews
                expect(subviews[0]).to(beAKindOf(UIImageView.self))
                expect(subviews[1]).to(beAKindOf(UIView.self))
            }
        }
    }
}

