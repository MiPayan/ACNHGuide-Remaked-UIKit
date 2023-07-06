//
//  SeaCreatureService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class SeaCreatureService {
    
    private let creatureManager: CreatureManaging
    
    init(creatureManager: CreatureManaging = CreatureManager()) {
        self.creatureManager = creatureManager
    }
}

extension SeaCreatureService: CreaturePeeking {
    var creaturesSaved: [Object] {
        creatureManager.getSavedCreatures(with: SeaCreature.self)
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let seaCreature = creatureManager.getCreature(with: SeaCreature.self, fileName: fileName)
        return seaCreature != nil
    }
}

extension SeaCreatureService: CreatureWriting {
    func saveCreature(fileName: String, completionHandler: @escaping (Error) -> Void) {
        let seaCreature = SeaCreature()
        seaCreature.fileName = fileName
        creatureManager.saveCreature(with: seaCreature, completionHandler: completionHandler)
    }
    
    func deleteCreature(fileName: String, completionHandler: @escaping (Error) -> Void) {
        if let seaCreature = creatureManager.getCreature(with: SeaCreature.self, fileName: fileName) {
            creatureManager.deleteCreature(with: seaCreature, completionHandler: completionHandler)
        }
    }
}
