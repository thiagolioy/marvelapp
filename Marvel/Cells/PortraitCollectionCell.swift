//
//  PortraitCollectionCell.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable

class PortraitCollectionCell: UICollectionViewCell, NibReusable, Charactable {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(character: Character) {
        if let thumbImage = character.thumImage {
            self.picture.download(image: (thumbImage.fullPath()))
            self.name.text = character.name
        }
    }
    
}
