//
//  FishCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import Foundation

final class FishCollectionViewCellViewModel {
    
    private let fish: FishData
    private let creaturePeeker: CreaturePeeking
    private let creatureWriter: CreatureWriting
    var errorCreatureDatabase: ((String) -> Void) = {_ in}
    
    init(
        fishData: FishData,
        creaturePeeker: CreaturePeeking = FishService(),
        creatureWriter: CreatureWriting = FishService()
    ) {
        self.fish = fishData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
    }
    
    var fileName: String {
        fish.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var iconURL: URL? {
        URL(string: fish.iconURI)
    }
}

extension FishCollectionViewCellViewModel {
    var isFishAlreadySaved: Bool {
        creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func toggleSavedFish() -> Bool {
        let isSaved = creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
        if isSaved {
            creatureWriter.deleteCreature(fileName: fileName) { [weak self] _ in
                guard let self else { return }
                errorCreatureDatabase("delete_database_error".localized)
            }
        } else {
            creatureWriter.saveCreature(fileName: fileName) { [weak self] _ in
                guard let self else { return }
                errorCreatureDatabase("save_database_error".localized)
            }
        }
        return !isSaved
    }
}
