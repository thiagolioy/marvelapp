//
//  newCharacterViewController.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import IGListKit

protocol Detailable {
    func showDetailsOf(character: Character)
}

class newCharacterViewController: UIViewController {

    var apiManager: MarvelAPICalls = MarvelAPIManager()
    var characters: [Character] = []
    
    let portraitToken: NSNumber = 1
    let searchToken: NSNumber = 2
    
    var embeddedSectionController: EmbeddedSectionController? = nil
    
    var filterString = ""
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    @IBOutlet weak var collectionView: IGListCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        fetchCharacters()
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchCharacters(for query: String? = nil) {
        apiManager.characters(query: query, skip: self.characters.count) { characters in
            if let characters = characters {
                self.characters += characters
                self.embeddedSectionController?.characters = self.characters
                self.adapter.performUpdates(animated: true)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func showDetailsOf(character: Character) {
        guard let nextController = Storyboard.Main.characterViewControllerScene
            .viewController() as? CharacterViewController else {
                return
        }
        
        nextController.character = character
        self.navigationController?.pushViewController(nextController, animated: true)
    }
}

extension newCharacterViewController: SearchSectionControllerDelegate {
    
    func searchSectionController(_ sectionController: SearchSectionController, didChangeText text: String) {
        filterString = text
        adapter.performUpdates(animated: true, completion: nil)
    }
}

extension newCharacterViewController: IGListAdapterDelegate {
    
    func listAdapter(_ listAdapter: IGListAdapter!, didEndDisplaying object: Any!, at index: Int) {
        
    }
    
    func listAdapter(_ listAdapter: IGListAdapter!, willDisplay object: Any!, at index: Int) {
        if self.characters.count - 5 == index {
            fetchCharacters()
        }
    }
}

extension newCharacterViewController: IGListAdapterDataSource {
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        
        var items:[IGListDiffable] = []
        
        if self.characters.count > 0 {
            items = [searchToken as IGListDiffable]
            items += [portraitToken as IGListDiffable]
        
            var filter: [IGListDiffable] = self.characters
            
            if filterString == "" {
                filter = self.characters.map{ (item: Character) -> IGListDiffable in
                    return item as IGListDiffable
                }
            } else {
                filter = self.characters.filter { (item:Character) -> Bool in
                    return item.name.lowercased().contains(filterString.lowercased()) }.map { $0 as IGListDiffable }
            }
            
            embeddedSectionController?.characters = filter
            return items + filter
        }
        
        return items
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        
        if let obj = object as? NSNumber, obj == portraitToken {
            embeddedSectionController = EmbeddedSectionController(characters: self.characters)
            if let embeddedSectionController = embeddedSectionController{
                return embeddedSectionController
            }
        } else if let obj = object as? NSNumber, obj == searchToken {
            let sectionController = SearchSectionController()
            sectionController.delegate = self
            return sectionController
        }
        
        return PictureSectionController()
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
}
