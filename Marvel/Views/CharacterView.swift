//
//  CharacterView.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharacterView: UIView {
    var image: UIImageView = {
        let img = UIImageView(frame: .zero)
        return img
    }()
    
    var containerView: UIView = {
        let lb = UIView(frame: .zero)
        lb.backgroundColor = ColorPalette.black
        lb.alpha = CGFloat(0.85)
        return lb
    }()
    
    var bio: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.numberOfLines = 0
        lb.textColor = ColorPalette.white
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CharacterView: ViewConfiguration {
    func setupConstraints() {
        image.snp.makeConstraints { make in
            make.top.equalTo(self).offset(64)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(350)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom)
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
        
        bio.snp.makeConstraints { make in
            make.edges.equalTo(containerView).inset(UIEdgeInsetsMake(15, 15, 15, 15))
        }
    }
    
    func buildViewHierarchy() {
        self.addSubview(image)
        containerView.addSubview(bio)
        self.addSubview(containerView)
    }
    
    func configureViews(){
        self.backgroundColor = ColorPalette.black
    }
}

extension CharacterView {
    func setup(with character: Character) {
        bio.text = character.bio.isEmpty ? "No description" : character.bio
        if let imagePath = character.thumImage?.fullPath() {
            image.download(image: imagePath)
        }
    }
}
