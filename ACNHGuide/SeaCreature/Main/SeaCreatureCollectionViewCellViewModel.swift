//
//  SeaCreatureCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import Foundation

final class SeaCreatureCollectionViewCellViewModel {
    
    private let seaCreatureData: SeaCreatureData
    private let creatureService = CreatureService(creatures: .seaCreatures)
    
    init(seaCreatureData: SeaCreatureData) {
        self.seaCreatureData = seaCreatureData
    }
    
    var fileName: String {
        seaCreatureData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var iconURL: URL? {
        URL(string: seaCreatureData.iconURI)
    }
    
    var isSeaCreatureAlreadySaved: Bool {
        creatureService.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func toggleSavedSeaCreature() -> Bool {
        let isSaved = creatureService.isCreatureAlreadySaved(fileName: fileName)
        if isSaved {
            creatureService.deleteCreature(fileName: fileName)
        } else {
            creatureService.saveCreature(fileName: fileName)
        }
        return !isSaved
    }
}
