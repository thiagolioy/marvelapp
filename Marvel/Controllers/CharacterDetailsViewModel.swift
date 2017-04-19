//
//  CharacterDetailsViewModel.swift
//  Marvel
//
//  Created by Thiago Lioy on 08/04/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import Action

struct CharacterDetailsViewModel: ViewModelType {
    
    let character: Character
    let coordinator: SceneCoordinatorType
    
    init(character: Character, coordinator: SceneCoordinatorType) {
        self.character = character
        self.coordinator = coordinator
    }
    
}
