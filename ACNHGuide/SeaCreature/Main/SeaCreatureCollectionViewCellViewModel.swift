//
//  SeaCreatureCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import Foundation

final class SeaCreatureCollectionViewCellViewModel {
    
    private let seaCreatureData: SeaCreatureData
    private let creaturePeeker: CreaturePeeking
    private let creatureWriter: CreatureWriting
    
    init(
        seaCreatureData: SeaCreatureData,
        creaturePeeker: CreaturePeeking = SeaCreatureService(),
        creatureWriter: CreatureWriting = SeaCreatureService()
    ) {
        self.seaCreatureData = seaCreatureData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
    }
    
    var fileName: String {
        seaCreatureData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var iconURL: URL? {
        URL(string: seaCreatureData.iconURI)
    }
}

extension SeaCreatureCollectionViewCellViewModel {
    var isSeaCreatureAlreadySaved: Bool {
        creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func toggleSavedSeaCreature() -> Bool {
        let isSaved = creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
        if isSaved {
            creatureWriter.deleteCreature(fileName: fileName)
        } else {
            creatureWriter.saveCreature(fileName: fileName)
        }
        return !isSaved
    }
}
