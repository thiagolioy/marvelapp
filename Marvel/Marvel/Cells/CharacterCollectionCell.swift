//
//  CharacterCollectionCell.swift
//  Marvel
//
//  Created by Thiago Lioy on 20/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Kingfisher

final class CharacterCollectionCell: UICollectionViewCell, ReusableCell {
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
        download(thumb: item.thumImage?.fullPath() ?? "")
    }
}

extension CharacterCollectionCell {
    func download(thumb url: String) {
        guard let imageURL = URL(string:url) else {
            return
        }
        thumb.kf.setImage(with: ImageResource(downloadURL: imageURL))
    }
}

