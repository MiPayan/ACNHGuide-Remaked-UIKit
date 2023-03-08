//
//  SeaCreatureService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class SeaCreatureService {
    
    private var creatureManager: RealmManager
    
    init(creatureManager: RealmManager = CreatureManager()) {
        self.creatureManager = creatureManager
    }
}

extension SeaCreatureService: CreaturePeeking {
    var creaturesSaved: [Object] {
        Array(creatureManager.realm.objects(SeaCreature.self))
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let seaCreature = creatureManager.realm.objects(SeaCreature.self).filter("fileName == %@", fileName).first
        return seaCreature != nil
    }
}

extension SeaCreatureService: CreatureWriting {
    func saveCreature(fileName: String) {
        let seaCreature = SeaCreature()
        seaCreature.fileName = fileName
        creatureManager.saveObject(with: seaCreature)
    }
    
    func deleteCreature(fileName: String) {
        if let seaCreature = creatureManager.realm.objects(SeaCreature.self).filter("fileName == %@", fileName).first {
            creatureManager.deleteObject(with: seaCreature)
        }
    }
}
