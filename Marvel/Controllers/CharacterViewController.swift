//
//  CharacterViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharacterViewController: UIViewController {
    var characterView = CharacterView()
    var character: Character?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = characterView
    }
}

extension CharacterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = character?.name ?? ""
    }
}


extension CharacterViewController {
    func setupView() {
        let bio = character?.bio ?? ""
        characterView.bio.text = bio.isEmpty ? "No description" : bio
        characterView.image.download(image: character?.thumImage?.fullPath() ?? "")
    }
}
