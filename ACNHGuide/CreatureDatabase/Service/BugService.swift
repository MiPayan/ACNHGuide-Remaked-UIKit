//
//  BugService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class BugService {
    
    private var creatureManager: CreatureManaging
    
    init(creatureManager: CreatureManaging = CreatureManager()) {
        self.creatureManager = creatureManager
    }
}

extension BugService: CreaturePeeking {
    var creaturesSaved: [Object] {
        creatureManager.getSavedCreatures(with: Bug.self)
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let bug = creatureManager.getCreature(with: Bug.self, fileName: fileName)
        return bug != nil
    }
}

extension BugService: CreatureWriting {
    func saveCreature(fileName: String) {
        let bug = Bug()
        bug.fileName = fileName
        creatureManager.saveCreature(with: bug)
    }
    
    func deleteCreature(fileName: String) {
        if let bug = creatureManager.getCreature(with: Bug.self, fileName: fileName) {
            creatureManager.deleteCreature(with: bug)
        }
    }
}
