//
//  CharacterCollectionCell.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import SnapKit

final class CharacterGridView: UIView {
    var image: UIImageView = {
        let img = UIImageView(frame: .zero)
        return img
    }()
    
    var name: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.textColor = ColorPalette.white
        return lb
    }()
    
    var containerView: UIView = {
        let lb = UIView(frame: .zero)
        lb.backgroundColor = ColorPalette.black
        lb.alpha = CGFloat(0.7)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildViewHierarchy()
        self.setupConstraints()
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterGridView: ViewConfiguration {
    func setupConstraints() {
        image.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        containerView.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(44)
        }
        
        name.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(15)
            make.right.equalTo(containerView).offset(15)
            make.height.equalTo(21)
            make.centerY.equalTo(containerView)
        }
    }
    
    func buildViewHierarchy() {
        self.addSubview(image)
        containerView.addSubview(name)
        self.addSubview(containerView)
    }
    
    func configureViews() {
    }
}
