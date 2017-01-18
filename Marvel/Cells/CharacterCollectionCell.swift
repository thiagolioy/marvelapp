//
//  CharacterCollectionCell.swift
//  Marvel
//
//  Created by Thiago Lioy on 20/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable

final class CharacterCollectionCell: UICollectionViewCell{
    let gridView = CharacterGridView()
    
    
    static func size(for parentWidth: CGFloat) -> CGSize {
        let numberOfCells = CGFloat(2)
        let width = parentWidth / numberOfCells
        return CGSize(width: width, height: width)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(item: Character) {
        gridView.setup(with: item)
    }
}

extension CharacterCollectionCell: Reusable {}

extension CharacterCollectionCell: ViewConfiguration {
    func setupConstraints() {
        gridView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView)
            make.left.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
        }
    }
    
    func buildViewHierarchy() {
        self.contentView.addSubview(gridView)
    }
}
