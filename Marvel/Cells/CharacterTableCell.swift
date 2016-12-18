//
//  CharacterTableCell.swift
//  Marvel
//
//  Created by Thiago Lioy on 15/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable


import UIKit

final class CharacterTableCell: UITableViewCell {
    var characterCell = CharacterCell()
    
    static func height() -> CGFloat {
        return 80
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(item: Character) {
        characterCell.name.text = item.name
        characterCell.bio.text = item.bio.isEmpty ? "No description" : item.bio
        characterCell.imageThumb.download(image: item.thumImage?.fullPath() ?? "")
    }
}

extension CharacterTableCell: Reusable {
}

extension CharacterTableCell: ViewConfiguration {
    func setupConstraints() {
        characterCell.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    func buildViewHierarchy() {
        self.contentView.addSubview(characterCell)
    }
    
    func configureViews() {
        self.contentView.backgroundColor = ColorPalette.black
        self.selectionStyle = .none
    }
}
