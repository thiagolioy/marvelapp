//
//  FavoriteView.swift
//  Marvel
//
//  Created by Thiago Lioy on 17/01/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit
import SnapKit

enum FavoriteViewState {
    case favourited, notFavourited
}

typealias Callback = () -> Void

class FavoriteView: UIView {
    
    var didFavorite: Callback?
    var didUnfavorite: Callback?
    
    var viewState: FavoriteViewState = .notFavourited {
        didSet {
            if viewState == .notFavourited {
                starImage.tintColor = UIColor.gray
            } else {
                starImage.tintColor = UIColor.yellow
            }
        }
    }
    
    let starImage: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = ImageAssets.star.image.withRenderingMode(.alwaysTemplate)
        img.tintColor = UIColor.gray
        return img
    }()
    
    let button: UIButton = {
        let bt = UIButton(frame: .zero)
        bt.setTitle("", for: .normal)
        bt.addTarget(self, action: #selector(touchUpInsideButton), for: .touchUpInside)
        return bt
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteView {
    @objc fileprivate func touchUpInsideButton() {
        if viewState == .favourited {
            didUnfavorite?()
            viewState = .notFavourited
        } else {
            viewState = .favourited
            didFavorite?()
        }
    }
}

extension FavoriteView: ViewConfiguration {
    func setupConstraints() {
        starImage.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
        button.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    func buildViewHierarchy() {
        self.addSubview(starImage)
        self.addSubview(button)
    }
}
