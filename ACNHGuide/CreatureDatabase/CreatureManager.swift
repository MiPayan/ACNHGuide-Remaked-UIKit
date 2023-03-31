//
//  CreatureManager.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 30/01/2023.
//

import Foundation
import RealmSwift

final class CreatureManager: CreatureManaging {
    
    var realm: Realm {
        try! Realm()
    }
    
    func getSavedCreatures<T: Object>(with creature: T.Type) -> [Object] {
        Array(realm.objects(T.self))
    }
    
    func getCreature<T: Object>(with creature: T.Type, fileName: String) -> Object? {
        realm.objects(T.self).filter("fileName == %@", fileName).first
    }
    
    func saveCreature(with object: Object) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error deleting object: \(error)")
        }
    }
    
    func deleteCreature(with object: Object) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting object: \(error)")
        }
    }
}
