//
//  FishService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 15/02/2023.
//

import Foundation
import RealmSwift

final class FishService {
    
    let realm = try! Realm()
    
    func getSavedFishes() -> [Fish] {
        realm.objects(Fish.self).map { $0 }
    }
    
//    func savedFishes(fishData: FishData) {
//        guard let id = try? ObjectId(string: String(fishData.id)) else { return }
//        if let fish = realm.object(ofType: Fish.self, forPrimaryKey: id) {
//            RealmManager.shared.deleteObject(with: fish)
//        } else {
//            RealmManager.shared.saveObject(with: fish)
//        }
//        try realm.write {
//            // Delete the Todo.
//            realm.write(<#T##block: (() throws -> Result)##(() throws -> Result)##() throws -> Result#>)
//        }
//    }
}
