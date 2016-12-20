//
//  HeaderCollectionCell.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable

class HeaderCollectionCell: UICollectionViewCell, NibReusable, Charactable {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    static func height() -> CGFloat {
        return 50.0
    }
    
    func setup(character: Character) {
        self.picture.image = nil
        
        if let thumbImage = character.thumImage {
            self.picture.download(image: thumbImage.fullPath())
            self.name.text = character.name
        }
    }
    
    override func prepareForReuse() {
        self.picture.cancelDownload()
    }
}
