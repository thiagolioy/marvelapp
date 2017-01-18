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

enum PresentationState {
    case table, collection
}

final class CharactersViewController: UIViewController {
    let apiManager: MarvelAPICalls
    
    var characters: [Character] = []
    
    var currentPresentationState = PresentationState.table
    
    let containerView = CharactersContainerView()
    
    init(apiManager: MarvelAPICalls) {
        self.apiManager = apiManager
        super.init(nibName: nil, bundle: nil)
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
        self.navigationItem.rightBarButtonItems = [
           NavigationItems.grid(self, #selector(showAsGrid(_:))).button(),
           NavigationItems.list(self, #selector(showAsTable(_:))).button()
        ]
    }
    
    func fetchCharacters(for query: String? = nil) {
        containerView.charactersTable.isHidden = true
        containerView.charactersCollection.isHidden = true
        containerView.activityIndicator.startAnimating()
        apiManager.characters(query: query) { characters in
            self.characters = characters ?? []
            self.containerView.activityIndicator.stopAnimating()
            switch self.currentPresentationState {
            case .table:
                self.setupTableView(with: self.characters)
            case .collection:
                self.setupCollectionView(with: self.characters)
            }
        }
    }
    
    func setupSearchBar() {
        self.containerView.searchBar.doSearch = { query in
            self.fetchCharacters(for: query)
        }
    }
    
    func setPresentationState(to state: PresentationState) {
        currentPresentationState = state
        switch state {
        case .collection:
            containerView.charactersTable.isHidden = true
            containerView.charactersCollection.isHidden = false
        case .table:
            containerView.charactersTable.isHidden = false
            containerView.charactersCollection.isHidden = true
        }
    }
    
    func setupTableView(with characters: [Character]) {
        setPresentationState(to: .table)
        containerView.charactersTable.updateItems(characters)
        containerView.charactersTable.didSelectCharacter = { [weak self] char in
            self?.navigateToNextController(with: char)
        }
    }
    
    func setupCollectionView(with characters: [Character]) {
        setPresentationState(to: .collection)
        containerView.charactersCollection.updateItems(characters)
        containerView.charactersCollection.didSelectCharacter = { [weak self] char in
            self?.navigateToNextController(with: char)
        }
    }
    
    func navigateToNextController(with character: Character) {
        self.containerView.searchBar.resignFirstResponder()
        let nextController = CharacterViewController(character: character)
        self.navigationController?.pushViewController(nextController, animated: true)
    }
}

extension CharactersViewController {
    func showAsGrid(_ sender: UIButton) {
        setupCollectionView(with: characters)
    }
    
    func showAsTable(_ sender: UIButton) {
        setupTableView(with: characters)
    }
}
