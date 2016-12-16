

//
//  PictureSectionController.swift
//  Herogram
//
//  Created by Rodrigo Cavalcante on 14/12/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import UIKit
import IGListKit
import Reusable

class PictureSectionController: IGListSectionController {
    var character: Character!
    let cells: [String] = [HeaderCollectionCell.reuseIdentifier, PictureCollectionCell.reuseIdentifier]
}

extension PictureSectionController: IGListSectionType {
    func numberOfItems() -> Int {
        return cells.count
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        if index == 1 {
            return CGSize(width: 375, height: 80)
        }
        
        return CGSize(width: 375, height: 50)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cellClass: String = cells[index]
        
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
