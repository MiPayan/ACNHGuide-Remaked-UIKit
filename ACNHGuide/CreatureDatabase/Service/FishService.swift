//
//  FishService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class FishService {
    
    private let creatureManager: CreatureManaging
    
    init(creatureManager: CreatureManaging = CreatureManager()) {
        self.creatureManager = creatureManager
    }
}

extension FishService: CreaturePeeking {
    var creaturesSaved: [Object] {
        creatureManager.getSavedCreatures(with: Fish.self)
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let fish = creatureManager.getCreature(with: Fish.self, fileName: fileName)
        return fish != nil
    }
}

extension FishService: CreatureWriting {
    func saveCreature(fileName: String, completionHandler: @escaping (Error) -> Void) {
        let fish = Fish()
        fish.fileName = fileName
        creatureManager.saveCreature(with: fish, completionHandler: completionHandler)
    }
    
    func deleteCreature(fileName: String, completionHandler: @escaping (Error) -> Void) {
        if let fish = creatureManager.getCreature(with: Fish.self, fileName: fileName) {
            creatureManager.deleteCreature(with: fish, completionHandler: completionHandler)
        }
    }
}
