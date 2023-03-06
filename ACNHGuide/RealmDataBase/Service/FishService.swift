//
//  FishService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class FishService {
    
    private var creatureManager: RealmManager
    
    init(creatureManager: RealmManager = CreatureManager()) {
        self.creatureManager = creatureManager
    }
}

extension FishService: CreaturePeeking {
    var creaturesSaved: [Object] {
        Array(creatureManager.realm.objects(Fish.self))
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let fish = creatureManager.realm.objects(Fish.self).filter("fileName == %@", fileName).first
        return fish != nil
    }
}

extension FishService: CreatureWriting {
    func saveCreature(fileName: String) {
        let fish = Fish()
        fish.fileName = fileName
        creatureManager.saveObject(with: fish)
    }
    
    func deleteCreature(fileName: String) {
        if let fish = creatureManager.realm.objects(Fish.self).filter("fileName == %@", fileName).first {
            creatureManager.deleteObject(with: fish)
        }
    }
}
