//
//  CharactersGrid.swift
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

struct GridConfig {
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        //Find out a better way to do this!!
        let parentWidth = UIApplication.shared.windows.first!.bounds.width
        layout.itemSize = CharacterCollectionCell.size(for: parentWidth)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }
}

class CharactersGrid: UICollectionView {
    let rxDatasource = RxCollectionViewSectionedReloadDataSource<CharacterSection>()
    
    
    init() {
        super.init(frame: .zero, collectionViewLayout: GridConfig.layout())
        configureStyle()
        configureDataSource()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func configureStyle() {
        isHidden = true
        backgroundColor = ColorPalette.black
        register(cellType: CharacterCollectionCell.self)
    }
    
    fileprivate func configureDataSource() {
        
        rxDatasource.configureCell = {
            dataSource, collectionView, indexPath, item in
            let cell = collectionView
                .dequeueReusableCell(for: indexPath, cellType:
                    CharacterCollectionCell.self)
            cell.setup(item: item)
            return cell
        }
    }
    
    func bindItems(observable: Observable<[CharacterSection]>) {
        observable
            .bindTo(rx.items(dataSource: rxDatasource))
            .addDisposableTo(self.rx_disposeBag)
    }
    
    func itemSelectedObservable() -> Observable<Character> {
        return rx.itemSelected
            .asObservable()
            .map { [unowned self] indexPath in
                try! self.rxDatasource.model(at: indexPath) as! Character
        }
    }

}
