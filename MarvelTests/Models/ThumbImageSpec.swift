//
//  ThumbImageSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 26/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Marvel

class ThumbImageSpec: QuickSpec {
    override func spec() {
        describe("a thumbImage") {
            
            var thumbImage = ThumbImage()
            
            it("should be able to create a chracter from json") {
                thumbImage.imageExtension = "png"
                thumbImage.path = "whatever"
                expect(thumbImage.fullPath()).to(equal("whatever.png"))
            }
        }
    }
}
