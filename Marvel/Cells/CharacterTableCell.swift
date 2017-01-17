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
    
    static func height() -> CGFloat {
        return 80
    }
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterRow.favoriteView.viewState = .notFavourited
    }
    
}

extension CharacterTableCell: Reusable {
}

extension CharacterTableCell: ViewConfiguration {
    func setupConstraints() {
        characterRow.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
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
