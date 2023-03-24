//
//  FishService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class FishService {
    
    private var realmManager: RealmManaging
    
    init(realmManager: RealmManaging = CreatureManager()) {
        self.realmManager = realmManager
    }
}

extension FishService: CreaturePeeking {
    var creaturesSaved: [Object] {
        realmManager.getSavedCreatures(with: Fish.self)
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let fish = realmManager.getCreature(with: Fish.self, fileName: fileName)
        return fish != nil
    }
}

extension FishService: CreatureWriting {
    func saveCreature(fileName: String) {
        let fish = Fish()
        fish.fileName = fileName
        realmManager.saveObject(with: fish)
    }
    
    func deleteCreature(fileName: String) {
        if let fish = realmManager.getCreature(with: Fish.self, fileName: fileName) {
            realmManager.deleteObject(with: fish)
        }
    }
}
