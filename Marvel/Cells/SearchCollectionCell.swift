//
//  SearchCollectionCell.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable

class SearchCollectionCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var searchBar: UISearchBar!
    
    static func height() -> CGFloat {
        return 44.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
