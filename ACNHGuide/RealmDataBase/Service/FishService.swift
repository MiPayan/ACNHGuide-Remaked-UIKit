//
//  FishService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class FishService: CreaturePeeking {
    var creaturesSaved: [Object] {
        Array(RealmManager.shared.realm.objects(Fish.self))
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let fish = RealmManager.shared.realm.objects(Fish.self).filter("fileName == %@", fileName).first
        return fish != nil
    }
}

extension FishService: CreatureWriting {
    func saveCreature(fileName: String) {
        let fish = Fish()
        fish.fileName = fileName
        RealmManager.shared.saveObject(with: fish)
    }
    
    func deleteCreature(fileName: String) {
        if let fish = RealmManager.shared.realm.objects(Fish.self).filter("fileName == %@", fileName).first {
            RealmManager.shared.deleteObject(with: fish)
        }
    }
}
