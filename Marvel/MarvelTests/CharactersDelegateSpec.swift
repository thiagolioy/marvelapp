//
//  CharactersDelegateSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 27/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Marvel


class CharactersDelegateMock: CharactersDelegate {
    var didSelectRowTrigged = false
    
    func didSelectCharacter(at index: IndexPath) {
        didSelectRowTrigged = true
    }
}

class CharactersDelegateSpec: QuickSpec {
    override func spec() {
        describe("CharactersDelegate") {
            
            var controller: CharactersViewController!
            var character: Marvel.Character!
            
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file: "character", in: testBundle)
                character = (mockLoader?.map(to: Character.self))!
                let apiMock = MarvelAPICallsMock(characters: [character])
                
                controller = Storyboard.Main.charactersViewControllerScene.viewController() as! CharactersViewController
                
                controller.apiManager = apiMock
                
                //Load view components
                let _ = controller.view
            }
            
            it("should have a valid datasource") {
                expect(controller.tableDelegate).toNot(beNil())
            }
            
            it("should have a cell of expected height") {
                let indexPath = IndexPath(row: 0, section: 0)
                let height = controller.tableDelegate!.tableView(controller.tableView, heightForRowAt: indexPath)
                expect(height).to(equal(80))
            }
            
            it("should call delegate on didSelectedRowAt") {
                let indexPath = IndexPath(row: 0, section: 0)
                let charactersDelegateMock = CharactersDelegateMock()
                controller.tableDelegate = CharactersTableDelegate(charactersDelegateMock)
                expect(charactersDelegateMock.didSelectRowTrigged).to(beFalsy())
                controller.tableDelegate!.tableView(controller.tableView, didSelectRowAt: indexPath)
                expect(charactersDelegateMock.didSelectRowTrigged).to(beTruthy())
            }
            
            
            
        }
    }
}
