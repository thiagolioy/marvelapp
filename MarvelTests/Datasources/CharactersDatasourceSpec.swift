//
//  CharactersDatasourceSpec.swift
//  Marvel
//
//  Created by Thiago Lioy on 07/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
@testable import Marvel

class TableViewDelegateMock: NSObject, UITableViewDelegate {

}

class CharactersDatasourceSpec: QuickSpec {
    override func spec() {
        describe("a CharactersDatasource ") {
            var datasource: CharactersDatasource!
            var character: Marvel.Character!
            var tableView: UITableView!
            
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file: "character", in: testBundle)
                character = mockLoader?.map(to: Character.self)
                
                
                tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
                datasource = CharactersDatasource(items: [character!], tableView: tableView, delegate: TableViewDelegateMock())
            }
            
            it("should have a valid datasource") {
                expect(datasource).toNot(beNil())
            }
            
            it("should have the expected number of items") {
                let count = datasource.tableView(tableView, numberOfRowsInSection: 0)
                expect(count).to(equal(1))
            }
            
            it("should have be able to update items") {
                datasource.updateItems([character!,character!,character!])
                let count = datasource.tableView(tableView, numberOfRowsInSection: 0)
                expect(count).to(equal(3))
            }
            
            it("should return the expected cell") {
                let cell = datasource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                expect(cell).to(beAKindOf(CharacterTableCell.self))
            }
            
        }
    }
}
