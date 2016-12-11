//
//  CharacterViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharacterViewController: UIViewController {
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var character: Character?
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
        characterDescription.text = bio.isEmpty ? "No description" : bio
        
        image.download(image: character?.thumImage?.fullPath() ?? "")
    }
}
