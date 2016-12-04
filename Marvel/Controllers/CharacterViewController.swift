//
//  CharacterViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharacterViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var character: Character?
}

extension CharacterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}


extension CharacterViewController {
    func setupView() {
        name.text = character?.name ?? ""
        image.download(image: character?.thumImage?.fullPath() ?? "")
    }
}
