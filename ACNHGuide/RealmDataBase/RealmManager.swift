//
//  RealmManager.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 30/01/2023.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    static let shared = RealmManager()
    private let realm = try! Realm()
    
    func fetchObject<T: Object>(type: T.Type) -> Results<T> {
           return realm.objects(type)
       }
    
    func saveObject<T: Object>(object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error saving object: \(error)")
        }
    }
    
    func deleteObject<T: Object>(object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting object: \(error)")
        }
    }
    
    func objectIsAlreadySaved() -> Bool {
        return true
    }

//    func objectIsAlreadySaved<T: String>(with filename: T) -> Bool {
//        let predicate = NSPredicate(format: "filename == %@", filename as! CVarArg)
//        return !realm.objects(T.self).filter(predicate).isEmpty
//    }
}
