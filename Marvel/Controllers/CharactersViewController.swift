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


final class CharactersViewController: UIViewController {
    
    
    let containerView = CharactersContainerView()
    var viewModel: CharactersViewModel
    
    let dataSource = RxTableViewSectionedReloadDataSource<CharacterSection>()
    let collectionDataSource = RxCollectionViewSectionedReloadDataSource<CharacterSection>()
    
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
            NavigationItems.grid(viewModel.switchToGridPresentation()).button(),
            NavigationItems.list(viewModel.switchToListPresentation()).button()
        ]
    }
    
    fileprivate func configureDataSource() {
        
        collectionDataSource.configureCell = {
            dataSource, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(for: indexPath,
                                               cellType: CharacterCollectionCell.self)
            cell.setup(item: item)
            return cell
        }
        
        dataSource.configureCell = {
            dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(for: indexPath,
                                                     cellType: CharacterTableCell.self)
            cell.setup(item: item)
            return cell
        }
    }
    
    func updateUI(for state: PresentationState) {
        switch state {
        case .collection:
            containerView.charactersTable.isHidden = true
            containerView.charactersCollection.isHidden = false
        case .table:
            containerView.charactersTable.isHidden = false
            containerView.charactersCollection.isHidden = true
        }
    }
    
    func updateLoadingState(for result: Result<[Character]>) {
        if case .loading = result {
            containerView.activityIndicator.isHidden = false
            containerView.activityIndicator.startAnimating()
        } else {
            containerView.activityIndicator.stopAnimating()
        }
    }
    
    func bindDatasource() {
        
        viewModel.presentationState
            .asObservable()
            .skip(1)
            .subscribe(onNext: {[weak self] state in
                self?.updateUI(for: state)
            }).addDisposableTo(self.rx_disposeBag)
        
        
        
        let itemsDriver = viewModel.sectionedItems
            .asObservable()
            
        itemsDriver
            .bindTo(containerView.charactersTable
                .rx.items(dataSource: dataSource))
            .addDisposableTo(self.rx_disposeBag)
        
        itemsDriver
            .bindTo(containerView.charactersCollection
                .rx.items(dataSource: collectionDataSource))
            .addDisposableTo(self.rx_disposeBag)
        
        
        let collectionItemSelected = containerView.charactersCollection.rx
            .itemSelected
            .asObservable()
        
        let tableItemSelected = containerView.charactersTable.rx
            .itemSelected
            .asObservable()
        
        Observable.merge([collectionItemSelected, tableItemSelected])
            .map { [unowned self] indexPath in
                try! self.dataSource.model(at: indexPath) as! Character
            }
            .subscribe(onNext:{
                _ = self.viewModel.presentDetails(of: $0)
            })
            .addDisposableTo(rx_disposeBag)
        
    }
    
    func fetchCharacters(for query: String? = nil) {
        
        let fetchObservable = viewModel.fetchCharacters(with: query)
            .shareReplay(1)
        
        fetchObservable
            .subscribe { event in
                if let element = event.element {
                    self.updateLoadingState(for: element)
                }
        }.addDisposableTo(rx_disposeBag)
        
        fetchObservable
            .subscribe { event in
                if case .completed = event{
                    self.updateUI(for: self.viewModel.presentationState.value)
                }
            }.addDisposableTo(rx_disposeBag)
        
        fetchObservable
            .map({
                if case Result.completed(let characters) = $0 {
                    return characters
                }
                return []
            })
            .map{[ CharacterSection(model: "", items: $0)]}
            .asDriver(onErrorJustReturn: [])
            .drive(self.viewModel.sectionedItems)
            .addDisposableTo(self.rx_disposeBag)
    }
    
    func setupSearchBar() {
        
        let searchInput = containerView.searchBar.rx.searchButtonClicked
            .asObservable()
            .map { self.containerView.searchBar.text }
            .filter { ($0 ?? "").characters.count > 0}
        
        searchInput.asObservable()
            .subscribe(onNext: { [weak self] text in
                self?.endEditingSearchBar()
                self?.fetchCharacters(for: text)
            }).addDisposableTo(self.rx_disposeBag)
        
        
        containerView.searchBar
            .rx.cancelButtonClicked
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                  self?.endEditingSearchBar()
            }).addDisposableTo(rx_disposeBag)
    }
    
    func endEditingSearchBar() {
        self.containerView.searchBar.text = ""
        self.containerView.searchBar.endEditing(true)
    }
    
}

