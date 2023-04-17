//
//  FossilService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift

final class FossilService {
    
    private let creatureManager: CreatureManaging
    
    init(creatureManager: CreatureManaging = CreatureManager()) {
        self.creatureManager = creatureManager
    }
}

extension FossilService: CreaturePeeking {
    var creaturesSaved: [Object] {
        creatureManager.getSavedCreatures(with: Fossil.self)
    }
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        let fossil = creatureManager.getCreature(with: Fossil.self, fileName: fileName)
        return fossil != nil
    }
}

extension FossilService: CreatureWriting {
    func saveCreature(fileName: String, completionHandler: @escaping (Error) -> Void) {
        let fossil = Fossil()
        fossil.fileName = fileName
        creatureManager.saveCreature(with: fossil, completionHandler: completionHandler)
    }
    
    func deleteCreature(fileName: String, completionHandler: @escaping (Error) -> Void) {
        if let fossil = creatureManager.getCreature(with: Fossil.self, fileName: fileName) {
            creatureManager.deleteCreature(with: fossil, completionHandler: completionHandler)
        }
    }
}
