//
//  CharactersCollectionDelegateSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 27/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Marvel


class CharactersCollectionDelegateMock: CharactersDelegate {
    var didSelectRowTrigged = false
    
    func didSelectCharacter(at index: IndexPath) {
        didSelectRowTrigged = true
    }
}

class CharactersCollectionDelegateSpec: QuickSpec {
    override func spec() {
        describe("CharactersCollectionDelegate") {
            
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
                controller.showAsGrid(UIButton())
            }
            
            it("should have a valid delegate") {
                expect(controller.collectionDelegate).toNot(beNil())
            }
            
            it("should have a cell of expected size") {
                let indexPath = IndexPath(row: 0, section: 0)
                let size = controller.collectionDelegate!.collectionView(controller.collectionView, layout: controller.collectionView.collectionViewLayout, sizeForItemAt: indexPath)
                let width = controller.collectionView.bounds.size.width
                let expectedSize = CharacterCollectionCell.size(for: width)
                expect(size.height).to(equal(expectedSize.height))
                expect(size.width).to(equal(expectedSize.width))
            }
            
            it("should call delegate on didSelectedRowAt") {
                let indexPath = IndexPath(row: 0, section: 0)
                let charactersDelegateMock = CharactersCollectionDelegateMock()
                controller.collectionDelegate = CharactersCollectionDelegate(charactersDelegateMock)
                expect(charactersDelegateMock.didSelectRowTrigged).to(beFalsy())
                controller.collectionDelegate!.collectionView(controller.collectionView, didSelectItemAt: indexPath)
                expect(charactersDelegateMock.didSelectRowTrigged).to(beTruthy())
            }
            
            
            
        }
    }
}

