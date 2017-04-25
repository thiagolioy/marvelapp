//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx


final class CharactersViewController: UIViewController {
    
    
    let containerView = CharactersContainerView()
    var viewModel: CharactersViewModel
    
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
        setupNavigationItem()
        setupSearchBar()
        setupSubscriptionToPresentationState()
        bindItemsToDatasource()
        fetchCharacters()
    }
    
    override func loadView() {
        self.view = containerView
    }
}

extension CharactersViewController: SceneControllerType {}

extension CharactersViewController {
    func setupNavigationItem() {
        self.navigationItem.title = "Characters"
        self.navigationItem.rightBarButtonItems = [
            NavigationItems.grid(viewModel.switchToGridPresentation()).button(),
            NavigationItems.list(viewModel.switchToListPresentation()).button()
        ]
    }
    
    func setupSearchBar() {
        containerView.searchBar.searchCallback = { [weak self] query in
            self?.fetchCharacters(for: query)
        }
    }
    
    
    func updateUI(for state: PresentationState) {
        switch state {
        case .collection:
            containerView.charactersTable.isHidden = true
            containerView.charactersGrid.isHidden = false
        case .table:
            containerView.charactersTable.isHidden = false
            containerView.charactersGrid.isHidden = true
        }
    }
}

extension CharactersViewController {
    
    func setupSubscriptionToPresentationState() {
        viewModel.presentationState
            .asObservable()
            .subscribe(onNext: {[weak self] state in
                self?.updateUI(for: state)
            }).addDisposableTo(self.rx_disposeBag)
    }
    
    func bindItemsToDatasource() {
        
        let itemsObs = viewModel.sectionedItems
            .asObservable()
            
        containerView.charactersTable
            .bindItems(observable: itemsObs)
        
        containerView.charactersGrid
            .bindItems(observable: itemsObs)
        
        
        Observable.merge([
            containerView.charactersTable
                .rowSelectedObservable(),
            containerView.charactersGrid
                .itemSelectedObservable()
            ])
            .subscribe(onNext:{ [weak self] item in
                self?.viewModel.presentDetails(of: item)
            }).addDisposableTo(rx_disposeBag)
        
    }
    
    
    func fetchCharacters(for query: String? = nil) {
        
        let fetchObservable = viewModel.fetchCharacters(with: query)
            .shareReplay(1)
        
        containerView.activityIndicator
            .bindLoadingState(for: fetchObservable)
    
        
        fetchObservable
            .map{$0.unwrap() ?? [] }
            .map{[ CharacterSection(model: "", items: $0)]}
            .asDriver(onErrorJustReturn: [])
            .drive(self.viewModel.sectionedItems)
            .addDisposableTo(rx_disposeBag)
    }
    
    
}

