//
//  FossilService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class FossilService {
    
    private var creatureManager: CreatureManaging
    
    init(creatureManager: CreatureManaging = CreatureManager()) {
        self.creatureManager = creatureManager
    }
}

extension FossilService: CreaturePeeking {
    var creaturesSaved: [Object] {
        creatureManager.getSavedCreatures(with: Fossil.self)
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let fossil = creatureManager.getCreature(with: Fossil.self, fileName: fileName)
        return fossil != nil
    }
}

extension FossilService: CreatureWriting {
    func saveCreature(fileName: String) {
        let fossil = Fossil()
        fossil.fileName = fileName
        creatureManager.saveCreature(with: fossil)
    }
    
    func deleteCreature(fileName: String) {
        if let fossil = creatureManager.getCreature(with: Fossil.self, fileName: fileName) {
            creatureManager.deleteCreature(with: fossil)
        }
    }
}
