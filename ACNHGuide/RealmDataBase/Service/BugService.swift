//
//  BugService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class BugService: CreaturePeeking {
    var creaturesSaved: [Object] {
        Array(RealmManager.shared.realm.objects(Bug.self))
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let fish = RealmManager.shared.realm.objects(Bug.self).filter("fileName == %@", fileName).first
        return fish != nil
    }
}

extension BugService: CreatureWriting {
    func saveCreature(fileName: String) {
        let fish = Bug()
        fish.fileName = fileName
        RealmManager.shared.saveObject(with: fish)
    }
    
    func deleteCreature(fileName: String) {
        if let fish = RealmManager.shared.realm.objects(Bug.self).filter("fileName == %@", fileName).first {
            RealmManager.shared.deleteObject(with: fish)
        }
    }
}
