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
    
    func setupLoadingState() {
        containerView.activityIndicator.isHidden = false
        containerView.activityIndicator.startAnimating()
    }
    
    func setupFinishedLoadingState() {
        containerView.activityIndicator.stopAnimating()
    }
    
    func setupSubscriptionToPresentationState() {
        viewModel.presentationState
            .asObservable()
            .skip(1)
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
            .subscribe(onNext:{
                self.viewModel.presentDetails(of: $0)
            }).addDisposableTo(rx_disposeBag)
        
    }
    
    func bindLoadingState(observable: Observable<Result<[Character]>>) {
        observable
            .filter{ $0.isLoading() }
            .subscribe {[weak self] _ in self?.setupLoadingState() }
            .addDisposableTo(rx_disposeBag)
        
        observable
            .filter{ !$0.isLoading() }
            .subscribe {[weak self] _ in self?.setupFinishedLoadingState() }
            .addDisposableTo(rx_disposeBag)
    }
    
    func bindPresentationState(observable: Observable<Result<[Character]>>) {
        observable
            .subscribe(onCompleted: { [weak self] _ in
                if let currentState = self?.viewModel.presentationState.value {
                    self?.viewModel.presentationState.value = currentState
                }
            }).addDisposableTo(rx_disposeBag)
    }
    
    
    func fetchCharacters(for query: String? = nil) {
        
        let fetchObservable = viewModel.fetchCharacters(with: query)
            .shareReplay(1)
        
        bindLoadingState(observable: fetchObservable)
        bindPresentationState(observable: fetchObservable)
        
        fetchObservable
            .filter{ $0.isSuccess() }
            .map { $0.unwrap() ?? [] }
            .map{[ CharacterSection(model: "", items: $0)]}
            .asDriver(onErrorJustReturn: [])
            .drive(self.viewModel.sectionedItems)
            .addDisposableTo(self.rx_disposeBag)
    }
    
    func setupSearchBar() {
        containerView.searchBar.searchCallback = { [weak self] query in
            self?.fetchCharacters(for: query)
        }
    }
    
    
}

