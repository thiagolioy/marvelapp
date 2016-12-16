
//
//  PortraitCollectionCell.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import IGListKit
import Reusable

class EmbeddedCollectionCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var collectionView: IGListCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        self.collectionView.collectionViewLayout = layout
        self.collectionView.alwaysBounceVertical = false
        self.collectionView.alwaysBounceHorizontal = true
    }    
}
