//
//  PortraitSectionController.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import IGListKit

class PortraitSectionController: IGListSectionController, IGListSectionType {
    
    var character: Character!
    var delegate: CharactersDelegate?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        let width = 150.0
        let height = 175.0
        return CGSize(width: width, height: height)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cellClass: String = PortraitCollectionCell.reuseIdentifier
        
        let cell = collectionContext!.dequeueReusableCell(withNibName: cellClass, bundle: Bundle.main, for: self, at: index)
        
        if let cell = cell as? Charactable{
            cell.setup(character: character)
        }
        
        return cell
    }
    
    func didUpdate(to object: Any) {
        character = object as? Character
    }
    
    func didSelectItem(at index: Int) {
        if let vc = self.viewController as? newCharacterViewController {
            vc.showDetailsOf(character: character)
        }
    }
    
}

