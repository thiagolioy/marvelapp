//
//  AppSearchBarSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 07/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class AppSearchBarSpec: QuickSpec {
    override func spec() {
        describe("a App Search Bar") {
            var searchBar: AppSearchBar!
            
            beforeEach {
                searchBar = AppSearchBar()
            }
            
            it("should have expected customized style") {
                expect(searchBar.showsCancelButton).to(beTruthy())
                expect(searchBar.searchBarStyle == .minimal).to(beTruthy())
            }
            
            it("should trigger do search callback") {
                searchBar.text = "bla bla"
                searchBar.doSearch = { text in
                    expect(text).to(equal("bla bla"))
                }
                
                searchBar.searchBarSearchButtonClicked(searchBar)
            }
            
            it("should trigger fatal error if init with coder") {
                expect { () -> Void in
                    let _ = AppSearchBar(coder: NSCoder())
                    }.to(throwAssertion())
            }
            
            it("should resign first respond if cancel button is clicked") {
                searchBar.becomeFirstResponder()
                searchBar.searchBarCancelButtonClicked(searchBar)
                expect(searchBar.isFirstResponder).to(beFalsy())
            }
            
            context("invalid search") {
                it("should not trigger do search callback for empty search text") {
                    searchBar.text = ""
                    searchBar.doSearch = { text in
                        fatalError("should not trigger this")
                    }
                    
                    searchBar.searchBarSearchButtonClicked(searchBar)
                }
                
                it("should not throw error if no callback is given") {
                    searchBar.text = "whatever"
                    searchBar.doSearch = nil
                    
                    expect { () -> Void in
                        searchBar.searchBarSearchButtonClicked(searchBar)
                        }.toNot(throwAssertion())
                }
            }
        }
    }
}
