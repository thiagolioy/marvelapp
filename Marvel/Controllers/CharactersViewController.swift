//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import ReSwift

protocol CharactersDelegate {
    func didSelectCharacter(at index: IndexPath)
}

enum PresentationState {
    case table, collection
}

final class CharactersViewController: UIViewController, StoreSubscriber {
    var currentPresentationState = PresentationState.table
    let containerView = CharactersContainerView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        store.subscribe(self) { state in
            state.fetchedCharactersState
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func newState(state: FetchedCharactersState) {
        switch state.characters {
        case .finished(let characters):
            updateUI(with: characters)
        default:
            break
        }
    }
    
    func setupLoadingState() {
        containerView.charactersTable.isHidden = true
        containerView.charactersCollection.isHidden = true
        containerView.activityIndicator.startAnimating()
    }
    
    deinit {
        store.unsubscribe(self)
    }
    
    func updateUI(with characters: [Character]) {
        self.containerView.activityIndicator.stopAnimating()
        switch self.currentPresentationState {
        case .table:
            self.setupTableView(with: characters)
        case .collection:
            self.setupCollectionView(with: characters)
        }
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
        setupLoadingState()
        store.dispatch(FetchCharactersAction(query: query))
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
        let result = store.state.fetchedCharactersState.characters
        switch result {
        case .finished(let characters):
            setupCollectionView(with: characters)
        default:
            break
        }
    }
    
    func showAsTable(_ sender: UIButton) {
        let result = store.state.fetchedCharactersState.characters
        switch result {
        case .finished(let characters):
            setupTableView(with: characters)
        default:
            break
        }
    }
}
