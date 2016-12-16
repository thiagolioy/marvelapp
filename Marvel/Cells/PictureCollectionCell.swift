//
//  PictureControlerCollectionViewCell.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable

protocol Charactable {
    func setup(character: Character)
}

class PictureCollectionCell: UICollectionViewCell, NibReusable, Charactable {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(character: Character) {
        if let thumbImage = character.thumImage {
            self.picture.download(image: (thumbImage.fullPath()))
            name.text = character.name
            characterDescription.text = character.bio.isEmpty ? "No description" : character.bio
        }
    }
}
