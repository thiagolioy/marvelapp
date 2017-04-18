//
//  CharactersTable.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/04/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxDataSources
import RxCocoa
import Action
import NSObject_Rx

class CharactersTable: UITableView {
    
    let rxDatasource = RxTableViewSectionedReloadDataSource<CharacterSection>()
    
    init() {
        super.init(frame: .zero, style: .plain)
        configureStyle()
        configureDataSource()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureStyle() {
        isHidden = true
        rowHeight = 80
        estimatedRowHeight = 80
        backgroundColor = ColorPalette.black
        register(cellType: CharacterTableCell.self)
    }
    
    fileprivate func configureDataSource() {
        
        rxDatasource.configureCell = {
            dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(for: indexPath,
                                                     cellType: CharacterTableCell.self)
            cell.setup(item: item)
            return cell
        }
    }
    
    func bindItems(observable: Observable<[CharacterSection]>) {
        observable
            .bindTo(rx.items(dataSource: rxDatasource))
            .addDisposableTo(self.rx_disposeBag)
    }
    
    func rowSelectedObservable() -> Observable<Character> {
        return rx.itemSelected
                .asObservable()
                .map { [unowned self] indexPath in
                    try! self.rxDatasource.model(at: indexPath) as! Character
                }
    }
}

