//
//  FossilService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class FossilService {
    
    private var creatureManager: RealmManager
    
    init(creatureManager: RealmManager = CreatureManager()) {
        self.creatureManager = creatureManager
    }
}

extension FossilService: CreaturePeeking {
    var creaturesSaved: [Object] {
        Array(creatureManager.realm.objects(Fossil.self))
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let fossil = creatureManager.realm.objects(Fossil.self).filter("fileName == %@", fileName).first
        return fossil != nil
    }
}

extension FossilService: CreatureWriting {
    func saveCreature(fileName: String) {
        let fossil = Fossil()
        fossil.fileName = fileName
        creatureManager.saveObject(with: fossil)
    }
    
    func deleteCreature(fileName: String) {
        if let fossil = creatureManager.realm.objects(Fossil.self).filter("fileName == %@", fileName).first {
            creatureManager.deleteObject(with: fossil)
        }
    }
}
