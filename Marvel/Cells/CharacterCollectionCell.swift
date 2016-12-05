//
//  CharacterCollectionCell.swift
//  Marvel
//
//  Created by Thiago Lioy on 20/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable

final class CharacterCollectionCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    
    static let paddingBtwCells = CGFloat(10)
    
    static func size(for parentWidth: CGFloat) -> CGSize {
        let numberOfCells = CGFloat(2)
        let totalPadding = CGFloat(numberOfCells+1) * paddingBtwCells
        let width = (parentWidth - totalPadding) / numberOfCells
        return CGSize(width: width, height: width)
    }
    
    func setup(item: Character) {
        name.text = item.name
        thumb.download(image: item.thumImage?.fullPath() ?? "")
    }
}
