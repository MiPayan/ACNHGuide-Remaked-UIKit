//
//  RealmManager.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 30/01/2023.
//

//import Foundation
//import RealmSwift
//
//final class RealmManager {
//    
//    static let shared = RealmManager()
//    private var realm: Realm {
//        try! Realm()
//    }
//    
//    func fetchObject<T: Object>(type: T.Type) -> Results<T> {
//        return realm.objects(type)
//    }
//    
//    func saveObject<T: Object>(object: T) {
//        do {
//            try realm.write {
//                realm.add(object, update: .modified)
//            }
//        } catch {
//            print("Error saving object: \(error)")
//        }
//    }
//    
//    func deleteObject<T: Object>(object: T) {
//        do {
//            try realm.write {
//                realm.delete(object)
//            }
//        } catch {
//            print("Error deleting object: \(error)")
//        }
//    }
//}
