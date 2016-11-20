//
//  CharacterTableCell.swift
//  Marvel
//
//  Created by Thiago Lioy on 15/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable

final class CharacterTableCell: UITableViewCell, NibReusable {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    
    static func height() -> CGFloat {
        return 80
    }
    
    func setup(item: Character) {
        name.text = item.name
        download(thumb: item.thumImage?.fullPath() ?? "")
    }
}

extension CharacterTableCell {
    func download(thumb url: String) {
        guard let imageURL = URL(string:url) else {
            return
        }
        thumb.kf.setImage(with: ImageResource(downloadURL: imageURL))
    }
}
