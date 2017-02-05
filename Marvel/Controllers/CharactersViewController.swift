//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

protocol CharactersDelegate {
    func didSelectCharacter(at index: Int)
}

final class CharactersViewController: UIViewController {
    var apiManager: MarvelAPICalls = MarvelAPIManager()
    
    var tableDatasource: CharactersDatasource?
    var tableDelegate: CharactersTableDelegate?
    
    var collectionDatasource: CharactersCollectionDatasource?
    var collectionDelegate: CharactersCollectionDelegate?
    
    var characters: [Character] = []
    
    var showingAsList = true
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
}

extension CharactersViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        fetchCharacters()
    }
}

extension CharactersViewController {
    func fetchCharacters(for query: String? = nil) {
        tableView.isHidden = true
        collectionView.isHidden = true
        activityIndicator.startAnimating()
        apiManager.characters(query: query, skip: self.characters.count) { characters in
            self.activityIndicator.stopAnimating()
            if let characters = characters {
                if self.showingAsList {
                    self.setupTableView(with: characters)
                } else {
                    self.setupCollectionView(with: characters)
                }
            }
        }
    }
    
    func setupSearchBar() {
        self.searchBar.delegate = self
    }
    
    func setupTableView(with characters: [Character]) {
        self.characters = characters
        showingAsList = true
        tableView.isHidden = false
        collectionView.isHidden = true
        tableDelegate = CharactersTableDelegate(self)
        tableDatasource = CharactersDatasource(items: characters, tableView: self.tableView, delegate: tableDelegate!)
    }
    
    func setupCollectionView(with characters: [Character]) {
        self.characters = characters
        showingAsList = false
        collectionView.isHidden = false
        tableView.isHidden = true
        collectionDelegate = CharactersCollectionDelegate(self)
        collectionDatasource = CharactersCollectionDatasource(items: characters, collectionView: self.collectionView, delegate: collectionDelegate!)
    }
}

extension CharactersViewController {
    @IBAction func showAsGrid(_ sender: UIButton) {
        setupCollectionView(with: characters)
    }
    
    @IBAction func showAsTable(_ sender: UIButton) {
        setupTableView(with: characters)
    }
}

extension CharactersViewController: CharactersDelegate {
    func didSelectCharacter(at index: Int) {
        searchBar.resignFirstResponder()
        guard let nextController = Storyboard.Main.characterViewControllerScene
            .viewController() as? CharacterViewController else {
            return
        }
        
        let character = characters[index]
        nextController.character = character
        self.navigationController?.pushViewController(nextController, animated: true)
    }
}

extension CharactersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query = searchBar.text ?? ""
        if !query.isEmpty {
            fetchCharacters(for: query)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

