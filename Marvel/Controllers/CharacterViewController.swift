//
//  CharacterViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharacterViewController: UIViewController {
    let characterView = CharacterView()
    let character: Character
    
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
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
        characterView.setup(with: character)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = character.name
    }
}
