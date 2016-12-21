//
//  CharactersTable.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharactersTable: UITableView {
    
    
    var didSelectCharacter: ((Character) -> Void)?
    
    fileprivate var customDatasource: CharactersDatasource?
    fileprivate var customDelegate: CharactersTableDelegate?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        customDelegate = CharactersTableDelegate(self)
        customDatasource = CharactersDatasource(items: [],
                                               tableView: self,
                                               delegate: customDelegate!)
        self.backgroundColor = ColorPalette.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CharactersTable {
    func updateItems(_ items: [Character]) {
        customDatasource?.updateItems(items)
    }
}

extension CharactersTable: CharactersDelegate {
    func didSelectCharacter(at index: IndexPath) {
        if let char = customDatasource?.items[index.row] {
            didSelectCharacter?(char)
        }
    }
}
