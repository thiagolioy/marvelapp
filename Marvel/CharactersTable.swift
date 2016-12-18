//
//  CharactersTable.swift
//  Marvel
//
//  Created by Thiago Lioy on 18/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharactersTable: UIView {
    
    var tableView: UITableView = {
        let tb = UITableView(frame: .zero)
        return tb
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

extension CharactersTable: ViewConfiguration {
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    func buildViewHierarchy() {
        self.addSubview(tableView)
    }
    
    func configureViews(){
        self.backgroundColor = ColorPalette.black
    }
}
