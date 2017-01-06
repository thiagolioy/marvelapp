//
//  CharactersViewControllerSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 05/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

struct MarvelAPICallsMock: MarvelAPICalls {
    let characters: [Marvel.Character]?
    
    func characters(query: String? = nil, completion: @escaping ([Marvel.Character]?) -> Void) {
        completion(characters)
    }
}

class CharactersViewControllerSpec: QuickSpec {
    override func spec() {
        describe("a characters view controller") {
            
            var controller: CharactersViewController!
            var character: Marvel.Character!
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file: "character", in: testBundle)
                character = mockLoader?.map(to: Character.self)
                let apiMock = MarvelAPICallsMock(characters: [character!])
                controller = CharactersViewController(apiManager: apiMock)
            }
            
            it("should be able to create a controller") {
                expect(controller).toNot(beNil())
            }
            
            it("should have a view of type") {
                expect(controller.view).to(beAKindOf(CharactersContainerView.self))
            }
            
            it("should have have the expected presentation style") {
                expect(controller.currentPresentationState == .table).to(beTruthy())
            }
            
            it("should change presentation style to collection after click on grid icon") {
                controller.showAsGrid(UIButton())
                expect(controller.currentPresentationState == .collection).to(beTruthy())
            }
            
            it("should change presentation style to table after click on row icon") {
                controller.currentPresentationState = .collection
                controller.showAsTable(UIButton())
                expect(controller.currentPresentationState == .table).to(beTruthy())
            }
            
            it("should trigger fatal error if init with coder") {
                expect { () -> Void in
                    let _ = CharactersViewController(coder: NSCoder())
                    }.to(throwAssertion())
            }
            
            context("nil response from api") {
                it("should follow regular flow and init characters with []"){
                    let apiMock = MarvelAPICallsMock(characters: nil)
                    let ct = CharactersViewController(apiManager: apiMock)
                    expect(ct.characters.isEmpty).to(beTruthy())
                }
                it("should follow regular flow and init characters with []"){
                    let apiMock = MarvelAPICallsMock(characters: nil)
                    let ct = CharactersViewController(apiManager: apiMock)
                    ct.currentPresentationState = .collection
                    ct.viewDidLoad()
                    expect(ct.characters.isEmpty).to(beTruthy())
                }
            }
            
            it("should setup search callback properly") {
                controller.setupSearchBar()
                expect(controller.containerView.searchBar.doSearch).toNot(beNil())
                expect { () -> Void in
                    controller.containerView
                        .searchBar.doSearch!("")
                    }.toNot(throwAssertion())
            }
            
            it("should setup didSelectCharacter callback properly for table") {
                controller.setupTableView(with: [])
                expect(controller.containerView
                    .charactersTable.didSelectCharacter).toNot(beNil())
                expect { () -> Void in
                    controller.containerView
                        .charactersTable.didSelectCharacter!(character!)
                    }.toNot(throwAssertion())
            }
            
            it("should setup didSelectCharacter callback properly for collection") {
                controller.setupCollectionView(with: [])
                expect(controller.containerView
                    .charactersCollection.didSelectCharacter).toNot(beNil())
                expect { () -> Void in
                    controller.containerView
                        .charactersCollection.didSelectCharacter!(character!)
                    }.toNot(throwAssertion())
            }
        }
    }
}


