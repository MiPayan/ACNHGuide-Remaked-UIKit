//
//  FishCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import Foundation

final class FishCollectionViewCellViewModel {
    
    private let fishData: FishData
    private let creaturePeeker: CreaturePeeking
    private let creatureWriter: CreatureWriting
    
    init(
        fishData: FishData,
        creaturePeeker: CreaturePeeking = FishService(),
        creatureWriter: CreatureWriting = FishService()
    ) {
        self.fishData = fishData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
    }
    
    var fileName: String {
        fishData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var iconURL: URL? {
        URL(string: fishData.iconURI)
    }
}

extension FishCollectionViewCellViewModel {
    var isFishAlreadySaved: Bool {
        creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func toggleSavedFish() -> Bool {
        let isSaved = creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
        if isSaved {
            creatureWriter.deleteCreature(fileName: fileName)
        } else {
            creatureWriter.saveCreature(fileName: fileName)
        }
        return !isSaved
    }
}
