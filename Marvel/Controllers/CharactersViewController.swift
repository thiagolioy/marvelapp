//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

protocol CharactersDelegate {
    func didSelectCharacter(at index: IndexPath)
}


final class CharactersViewController: UIViewController {
    var apiManager: MarvelAPICalls = MarvelAPIManager()
    
    var tableDatasource: CharactersDatasource?
    var tableDelegate: CharactersTableDelegate?
    
    var collectionDatasource: CharactersCollectionDatasource?
    var collectionDelegate: CharactersCollectionDelegate?
    
    var characters: [Character] = []
    
    var showingAsList = false
    
    let containerView = CharactersContainerView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharactersViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupSearchBar()
        fetchCharacters()
    }
    
    override func loadView() {
        self.view = containerView
    }
}

extension CharactersViewController {
    func setupNavigationItem() {
        self.navigationItem.title = "Characters"
        
        let listButton = UIBarButtonItem(image: UIImage(named: "List Icon"), style: .plain, target: self, action: #selector(showAsTable(_:)))
        
        let gridButton = UIBarButtonItem(image: UIImage(named: "Grid Icon"), style: .plain, target: self, action: #selector(showAsGrid(_:)))
        
        self.navigationItem.rightBarButtonItems = [gridButton, listButton]
    }
    
    func fetchCharacters(for query: String? = nil) {
        containerView.charactersTable.isHidden = true
        containerView.charactersCollection.isHidden = true
        containerView.activityIndicator.startAnimating()
        apiManager.characters(query: query) { characters in
            self.containerView.activityIndicator.stopAnimating()
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
        self.containerView.searchBar.delegate = self
    }
    
    func setupTableView(with characters: [Character]) {
        self.characters = characters
        showingAsList = true
        containerView.charactersTable.isHidden = false
        containerView.charactersCollection.isHidden = true
        tableDelegate = CharactersTableDelegate(self)
        tableDatasource = CharactersDatasource(items: characters, tableView: containerView.charactersTable.tableView, delegate: tableDelegate!)
    }
    
    func setupCollectionView(with characters: [Character]) {
        self.characters = characters
        showingAsList = false
        containerView.charactersCollection.isHidden = false
        containerView.charactersTable.isHidden = true
        collectionDelegate = CharactersCollectionDelegate(self)
        collectionDatasource = CharactersCollectionDatasource(items: characters, collectionView: containerView.charactersCollection.collectionView, delegate: collectionDelegate!)
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
    func didSelectCharacter(at index: IndexPath) {
        containerView.searchBar.resignFirstResponder()
        let nextController = CharacterViewController()
        let character = characters[index.row]
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

