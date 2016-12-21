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

fileprivate enum PresentationState {
    case table, collection
}

final class CharactersViewController: UIViewController {
    var apiManager: MarvelAPICalls = MarvelAPIManager()
    
    var characters: [Character] = []
    
    fileprivate var currentPresentationState = PresentationState.table
    
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
        self.navigationItem.rightBarButtonItems = [
           NavigationItems.grid(self, #selector(showAsGrid(_:))).button(),
           NavigationItems.list(self, #selector(showAsTable(_:))).button()
        ]
    }
    
    func fetchCharacters(for query: String? = nil) {
        containerView.charactersTable.isHidden = true
        containerView.charactersCollection.isHidden = true
        
        apiManager.characters(query: query) { characters in
            self.characters = characters ?? []
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
    
    fileprivate func setPresentationState(to state: PresentationState) {
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
        let nextController = CharacterViewController()
        nextController.character = character
        self.navigationController?.pushViewController(nextController, animated: true)
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
