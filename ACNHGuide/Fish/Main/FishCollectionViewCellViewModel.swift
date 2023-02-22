//
//  FishCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import Foundation

final class FishCollectionViewCellViewModel {
    
    private let fishData: FishData
    private let creatureService = CreatureService(creatures: .fishes)
    
    init(fishData: FishData) {
        self.fishData = fishData
    }
    
    var fileName: String {
        fishData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var iconURL: URL? {
        URL(string: fishData.iconURI)
    }
    
    var isFishAlreadySaved: Bool {
        creatureService.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func toggleSavedFish() -> Bool {
        let isSaved = creatureService.isCreatureAlreadySaved(fileName: fileName)
        if isSaved {
            creatureService.deleteCreature(fileName: fileName)
        } else {
            creatureService.saveCreature(fileName: fileName)
        }
        return !isSaved
    }
}
