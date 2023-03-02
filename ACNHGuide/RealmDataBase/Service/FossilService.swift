//
//  FossilService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class FossilService: CreaturePeeking {
    var creaturesSaved: [Object] {
        Array(RealmManager.shared.realm.objects(Fossil.self))
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let fish = RealmManager.shared.realm.objects(Fossil.self).filter("fileName == %@", fileName).first
        return fish != nil
    }
}

extension FossilService: CreatureWriting {
    func saveCreature(fileName: String) {
        let fish = Fossil()
        fish.fileName = fileName
        RealmManager.shared.saveObject(with: fish)
    }
    
    func deleteCreature(fileName: String) {
        if let fish = RealmManager.shared.realm.objects(Fossil.self).filter("fileName == %@", fileName).first {
            RealmManager.shared.deleteObject(with: fish)
        }
    }
}
