//
//  CharactersTableDelegateSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 07/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class CharactersDelegateMock: NSObject, CharactersDelegate {
    var didTriggerDelegate = false
    
    func didSelectCharacter(at index: IndexPath) {
        didTriggerDelegate = true
    }
}

class CharactersTableDelegateSpec: QuickSpec {
    override func spec() {
        
        describe("a Characters Table Delegate  ") {
            var delegate: CharactersTableDelegate!
            var mock: CharactersDelegateMock!
            beforeEach {
                mock = CharactersDelegateMock()
                delegate = CharactersTableDelegate(mock)
            }
            
            it("should trigger charactersDelegate") {
                mock.didTriggerDelegate = false
                delegate.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
                expect(mock.didTriggerDelegate).to(beTruthy())
            }
        }
    }
}
