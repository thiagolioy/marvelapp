//
//  HorizontalSectionController.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import IGListKit

class EmbeddedSectionController: IGListSectionController, IGListSectionType {
    
    let searchToken: NSNumber = 0
    
    lazy var adapter: IGListAdapter = {
        let adapter = IGListAdapter(updater: IGListAdapterUpdater(),
                                    viewController: self.viewController,
                                    workingRangeSize: 0)
        adapter.dataSource = self
        return adapter
    }()
    
    var characters: [IGListDiffable] = [] {
        didSet {
        adapter.performUpdates(animated: true, completion: nil)
        }
    }
    
    init(characters: [IGListDiffable]) {
        super.init()
        self.characters = characters
    }
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        let width = Double(collectionContext!.containerSize.width)
        let height = EmbeddedCollectionCell.height()
        return CGSize(width: width, height: height)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(withNibName: EmbeddedCollectionCell.reuseIdentifier, bundle: Bundle.main, for: self, at: index) as! EmbeddedCollectionCell
        
        adapter.collectionView = cell.collectionView
        return cell
    }
    
    func didUpdate(to object: Any) {
    
    }
    
    func didSelectItem(at index: Int) {

    }
    
}

extension EmbeddedSectionController: IGListAdapterDataSource{
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return self.characters
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return PortraitSectionController()
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}
