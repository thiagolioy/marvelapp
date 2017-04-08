//
//  CharactersViewModel.swift
//  Marvel
//
//  Created by Thiago Lioy on 08/04/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import Action

typealias CharacterSection = AnimatableSectionModel<String, Character>

struct CharactersViewModel {
    let marvelService: MarvelServiceType
    let coordinator: SceneCoordinatorType
    
    init(marvelService: MarvelServiceType, coordinator: SceneCoordinatorType) {
        self.marvelService = marvelService
        self.coordinator = coordinator
    }
    
    func fetchCharacters(with query: String? = nil) -> Observable<[Character]> {
        return marvelService.characters(query: query)
    }
    
    var sectionedItems: Variable<[CharacterSection]> = Variable([])
    
    func presentDetails(of character: Character) -> Observable<Void> {
        let viewModel = CharacterDetailsViewModel(
            character: character,
            coordinator: coordinator
        )
        let nextScene = Scene.characterDetails(viewModel)
        return coordinator.transition(to: nextScene, type: .push)
    }
}
