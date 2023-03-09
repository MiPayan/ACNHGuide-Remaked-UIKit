//
//  FossilService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class FossilService {
    
    private var realmManager: RealmManaging
    
    init(realmManager: RealmManaging = CreatureManager()) {
        self.realmManager = realmManager
    }
}

extension FossilService: CreaturePeeking {
    var creaturesSaved: [Object] {
        Array(realmManager.realm.objects(Fossil.self))
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let fossil = realmManager.realm.objects(Fossil.self).filter("fileName == %@", fileName).first
        return fossil != nil
    }
}

extension FossilService: CreatureWriting {
    func saveCreature(fileName: String) {
        let fossil = Fossil()
        fossil.fileName = fileName
        realmManager.saveObject(with: fossil)
    }
    
    func deleteCreature(fileName: String) {
        if let fossil = realmManager.realm.objects(Fossil.self).filter("fileName == %@", fileName).first {
            realmManager.deleteObject(with: fossil)
        }
    }
}
