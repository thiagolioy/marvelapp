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

class NewTestSpec: QuickSpec {
    override func spec() {
        describe("the First test") {
            it("has to pass") {
                let char = Character()
                expect(char.name).to(equal(""))
            }
            
        }
    }
}
