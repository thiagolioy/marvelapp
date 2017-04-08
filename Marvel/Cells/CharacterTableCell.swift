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
    var characterRow = CharacterRowView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(item: Character) {
        characterRow.setup(with: item)
    }
    
}

extension CharacterTableCell: Reusable {
}

extension CharacterTableCell: ViewConfiguration {
    func setupConstraints() {
        characterRow.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func buildViewHierarchy() {
        self.contentView.addSubview(characterRow)
    }
    
    func configureViews() {
        self.contentView.backgroundColor = ColorPalette.black
        self.selectionStyle = .none
    }
}
