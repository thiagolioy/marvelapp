//
//  CharacterCell.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import SnapKit

final class CharacterRowView: UIView {
    
    let imageThumb: UIImageView = {
        let img = UIImageView(frame: .zero)
        return img
    }()
    
    let name: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.textColor = ColorPalette.white
        return lb
    }()
    
    let bio: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.numberOfLines = 0
        lb.textColor = ColorPalette.white
        return lb
    }()
    
    let favoriteView = FavoriteView()
    
    let realmManager = RealmManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterRowView {
    func setup(with character: Character){
        name.text = character.name
        bio.text = character.bio.isEmpty ? "No description" : character.bio
        if let imagePath = character.thumImage?.fullPath() {
            imageThumb.download(image: imagePath)
        }
        
        realmManager.isFavorite(character: character) { [weak self] isFavorite in
            self?.favoriteView.viewState = isFavorite ?
                .favourited : .notFavourited
        }
        
        favoriteView.didFavorite = { [weak self] in
            self?.realmManager.favorite(character: character)
        }
        
        favoriteView.didUnfavorite = { [weak self] in
            self?.realmManager.unfavorite(character: character)
        }
        
    }
}

extension CharacterRowView: ViewConfiguration {
    func setupConstraints() {
        imageThumb.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(self.snp.height)
        }
        
        favoriteView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(44)
            make.top.equalTo(self)
            make.right.equalTo(self)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(imageThumb.snp.right).offset(15)
            make.right.equalTo(favoriteView).offset(-10)
            make.height.equalTo(21)
        }
        
        bio.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(8)
            make.left.equalTo(imageThumb.snp.right).offset(15)
            make.right.equalTo(favoriteView).offset(-10)
            make.bottom.equalTo(self).offset(-15)
        }
    }
    
    func buildViewHierarchy() {
        self.addSubview(imageThumb)
        self.addSubview(favoriteView)
        self.addSubview(name)
        self.addSubview(bio)
    }
}

