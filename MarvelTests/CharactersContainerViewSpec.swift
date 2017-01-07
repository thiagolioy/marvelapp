//
//  CharactersContainerViewSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 07/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class CharactersContainerViewSpec: QuickSpec {
    override func spec() {
        describe("a Characters Container View ") {
            var container: CharactersContainerView!
            
            
            beforeEach {
                container = CharactersContainerView()
            }
            
            it("should trigger fatal error if init with coder") {
                expect { () -> Void in
                    let _ = CharactersContainerView(coder: NSCoder())
                    }.to(throwAssertion())
            }
            
            it("should have expected background color") {
                expect(container.backgroundColor == ColorPalette.black).to(beTruthy())
            }
            
            it("should have expected number of subviews") {
                let subviews = container.subviews
                expect(subviews.count).to(equal(3))
            }
            
            it("should have expected subviews") {
                let subviews = container.subviews
                expect(subviews[0]).to(beAKindOf(AppSearchBar.self))
                expect(subviews[1]).to(beAKindOf(CharactersTable.self))
                expect(subviews[2]).to(beAKindOf(CharactersCollection.self))
            }

        }
    }

}
