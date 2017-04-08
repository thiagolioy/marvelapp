//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa
import Action
import NSObject_Rx

protocol CharactersDelegate {
    func didSelectCharacter(at index: IndexPath)
}

enum PresentationState {
    case table, collection
}

final class CharactersViewController: UIViewController {
    
    
    var currentPresentationState = PresentationState.table
    
    let containerView = CharactersContainerView()
    let viewModel: CharactersViewModel
    
    let dataSource = RxTableViewSectionedAnimatedDataSource<CharacterSection>()
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CharactersViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        setupNavigationItem()
        setupSearchBar()
        bindDatasource()
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
    
    fileprivate func configureDataSource() {

        dataSource.configureCell = {
            dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableCell.reuseIdentifier, for: indexPath) as! CharacterTableCell
            cell.setup(item: item)
            return cell
        }
    }
    
    func bindDatasource() {
        viewModel.sectionedItems
            .asObservable()
            .bindTo(containerView.charactersTable
                .rx.items(dataSource: dataSource))
            .addDisposableTo(self.rx_disposeBag)
        
        
        containerView.charactersTable.rx
            .itemSelected
            .map { [unowned self] indexPath in
                try! self.dataSource.model(at: indexPath) as! Character
            }
            .subscribe(onNext:{
                _ = self.viewModel.presentDetails(of: $0)
            })
            .addDisposableTo(rx_disposeBag)
    }
    
    func fetchCharacters(for query: String? = nil) {
//        containerView.charactersTable.isHidden = true
        containerView.charactersCollection.isHidden = true
//        containerView.activityIndicator.startAnimating()
        
        viewModel.fetchCharacters(with: query)
            .map{[ CharacterSection(model: "", items: $0)]}
            .bindTo(self.viewModel.sectionedItems)
            .addDisposableTo(self.rx_disposeBag)

    
        

//        apiManager.characters(query: query) { characters in
//            self.characters = characters ?? []
//            self.containerView.activityIndicator.stopAnimating()
//            switch self.currentPresentationState {
//            case .table:
//                self.setupTableView(with: self.characters)
//            case .collection:
//                self.setupCollectionView(with: self.characters)
//            }
//        }
    }
    
    func setupSearchBar() {
        let searchInput = containerView.searchBar.rx.searchButtonClicked
            .asObservable()
            .map { self.containerView.searchBar.text }
            .filter { ($0 ?? "").characters.count > 0}
        
        searchInput.asObservable()
            .subscribe(onNext: { [weak self] text in
                self?.fetchCharacters(for: text)
            }).addDisposableTo(self.rx_disposeBag)
        
        
        
        
//        let searchInput =
//            containerView.searchBar.rx.controlEvent(.editingDidEndOnExit).asObservable()
//                .map { containerView.searchBar.text }
//                .filter { ($0 ?? "").characters.count > 0 }
        
//        self.containerView.searchBar.doSearch = { query in
//            self.fetchCharacters(for: query)
//        }
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
    
//    func setupTableView(with characters: [Character]) {
//        setPresentationState(to: .table)
//        containerView.charactersTable.updateItems(characters)
//        containerView.charactersTable.didSelectCharacter = { [weak self] char in
//            self?.navigateToNextController(with: char)
//        }
//    }
//    
//    func setupCollectionView(with characters: [Character]) {
//        setPresentationState(to: .collection)
//        containerView.charactersCollection.updateItems(characters)
//        containerView.charactersCollection.didSelectCharacter = { [weak self] char in
//            self?.navigateToNextController(with: char)
//        }
//    }
    
//    func navigateToNextController(with character: Character) {
//        self.containerView.searchBar.resignFirstResponder()
//        let nextController = CharacterViewController(character: character)
//        self.navigationController?.pushViewController(nextController, animated: true)
//    }
}

extension CharactersViewController {
    func showAsGrid(_ sender: UIButton) {
//        setupCollectionView(with: characters)
    }
    
    func showAsTable(_ sender: UIButton) {
//        setupTableView(with: characters)
    }
}
