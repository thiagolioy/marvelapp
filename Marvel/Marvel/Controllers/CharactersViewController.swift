//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

final class CharactersViewController: UIViewController {
    let apiManager = MarvelAPIManager()
    var datasource: CharactersDatasource?
    var delegate: CharactersDelegate?
    
    var characters: [Character] = []
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
}

extension CharactersViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
    }
}

extension CharactersViewController {
    func fetchCharacters() {
        activityIndicator.startAnimating()
        apiManager.characters { characters in
            self.activityIndicator.stopAnimating()
            if let characters = characters {
                self.setupTableView(with: characters)
            }
        }
    }
    
    func setupTableView(with characters: [Character]) {
        self.characters = characters
        tableView.isHidden = false
        delegate = CharactersDelegate()
        datasource = CharactersDatasource(items: characters, tableView: self.tableView, delegate: delegate!)
    }
}
