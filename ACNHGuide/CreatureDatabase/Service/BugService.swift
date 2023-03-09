//
//  BugService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class BugService {
    
    private var realmManager: RealmManaging
    
    init(realmManager: RealmManaging = CreatureManager()) {
        self.realmManager = realmManager
    }
}

extension BugService: CreaturePeeking {
    var creaturesSaved: [Object] {
        Array(realmManager.realm.objects(Bug.self))
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let bug = realmManager.realm.objects(Bug.self).filter("fileName == %@", fileName).first
        return bug != nil
    }
}

extension BugService: CreatureWriting {
    func saveCreature(fileName: String) {
        let bug = Bug()
        bug.fileName = fileName
        realmManager.saveObject(with: bug)
    }
    
    func deleteCreature(fileName: String) {
        if let bug = realmManager.realm.objects(Bug.self).filter("fileName == %@", fileName).first {
            realmManager.deleteObject(with: bug)
        }
    }
}
