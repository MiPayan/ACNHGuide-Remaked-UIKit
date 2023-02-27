//
//  FossilDetailsTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 31/01/2023.
//

import Foundation

final class FossilDetailsTableViewCellViewModel {
    
    private let fossilData: FossilData
    private let creatureService = CreatureService(creatures: .fossils)
    
    init(fossilData: FossilData) {
        self.fossilData = fossilData
    }
    
    var fileName: String {
        fossilData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var imageURL: URL? {
        guard let imageURL = URL(string: fossilData.imageURI) else { return nil }
        return imageURL
    }
    
    var price: String {
        String(fossilData.price)
    }
    
    var museumPhrase: String {
        fossilData.museumPhrase
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
