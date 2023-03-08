//
//  BugService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class BugService {
    
    private var creatureManager: RealmManager
    
    init(creatureManager: RealmManager = CreatureManager()) {
        self.creatureManager = creatureManager
    }
}

extension BugService: CreaturePeeking {
    var creaturesSaved: [Object] {
        Array(creatureManager.realm.objects(Bug.self))
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let bug = creatureManager.realm.objects(Bug.self).filter("fileName == %@", fileName).first
        return bug != nil
    }
}

extension BugService: CreatureWriting {
    func saveCreature(fileName: String) {
        let bug = Bug()
        bug.fileName = fileName
        creatureManager.saveObject(with: bug)
    }
    
    func deleteCreature(fileName: String) {
        if let bug = creatureManager.realm.objects(Bug.self).filter("fileName == %@", fileName).first {
            creatureManager.deleteObject(with: bug)
        }
    }
}
