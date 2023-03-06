//
//  RealmManager.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 30/01/2023.
//

import Foundation
import RealmSwift

protocol RealmManager {
    var realm: Realm { get }
    func saveObject(with object: Object)
    func deleteObject(with object: Object)
}

final class CreatureManager: RealmManager {
    
    var realm: Realm {
        try! Realm()
    }
    
    func saveObject(with object: Object) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error deleting object: \(error)")
        }
    }
    
    func deleteObject(with object: Object) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting object: \(error)")
        }
    }
}
