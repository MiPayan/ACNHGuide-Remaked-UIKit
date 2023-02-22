//
//  FossilCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import Foundation

final class FossilCollectionViewCellViewModel {
    
    private let fossilData: FossilData
    private let creatureService = CreatureService(creatures: .fossils)
    
    init(fossilData: FossilData) {
        self.fossilData = fossilData
    }
    
    var fileName: String {
        fossilData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var imageURL: URL? {
        URL(string: fossilData.imageURI)
    }
    
    var isFossilAlreadySaved: Bool {
        creatureService.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func toggleSavedFossil() -> Bool {
        let isSaved = creatureService.isCreatureAlreadySaved(fileName: fileName)
        if isSaved {
            creatureService.deleteCreature(fileName: fileName)
        } else {
            creatureService.saveCreature(fileName: fileName)
        }
        return !isSaved
    }
}
