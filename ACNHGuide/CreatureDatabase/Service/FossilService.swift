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
        realmManager.getSavedCreatures(with: Fossil.self)
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let fossil = realmManager.getCreature(with: Fossil.self, fileName: fileName)
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
        if let fossil = realmManager.getCreature(with: Fossil.self, fileName: fileName) {
            realmManager.deleteObject(with: fossil)
        }
    }
}
