//
//  CharacterViewControllerSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 27/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Marvel


class CharacterViewControllerSpec: QuickSpec {
    override func spec() {
        describe("CharacterViewController") {
            
            var controller: CharacterViewController!
            var character: Marvel.Character!
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file: "character", in: testBundle)
                character = (mockLoader?.map(to: Character.self))!
                
                
                controller = Storyboard.Main.characterViewControllerScene.viewController() as! CharacterViewController
                
                controller.character = character
                
                //Load view components
                let _ = controller.view
            }
            
            context("valid character") {
                it("should setup properties with character information") {
                    controller.viewDidLoad()
                    let description = controller.characterDescription.text
                    let expectedDescription = character.bio.isEmpty ? "No description" : character.bio
                    expect(description).to(equal(expectedDescription))
                }
            }
            
            context("nil character") {
                it("should setup properties with default values") {
                    controller.character = nil
                    controller.viewDidLoad()
                    let description = controller.characterDescription.text
                    expect(description).to(equal("No description"))
                }
            }
        }
    }
}
