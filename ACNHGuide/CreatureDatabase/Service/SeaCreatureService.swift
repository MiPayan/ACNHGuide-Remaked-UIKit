//
//  SeaCreatureService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class SeaCreatureService {
    
    private var realmManager: RealmManaging
    
    init(realmManager: RealmManaging = CreatureManager()) {
        self.realmManager = realmManager
    }
}

extension SeaCreatureService: CreaturePeeking {
    var creaturesSaved: [Object] {
        Array(realmManager.realm.objects(SeaCreature.self))
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let seaCreature = realmManager.realm.objects(SeaCreature.self).filter("fileName == %@", fileName).first
        return seaCreature != nil
    }
}

extension SeaCreatureService: CreatureWriting {
    func saveCreature(fileName: String) {
        let seaCreature = SeaCreature()
        seaCreature.fileName = fileName
        realmManager.saveObject(with: seaCreature)
    }
    
    func deleteCreature(fileName: String) {
        if let seaCreature = realmManager.realm.objects(SeaCreature.self).filter("fileName == %@", fileName).first {
            realmManager.deleteObject(with: seaCreature)
        }
    }
}
