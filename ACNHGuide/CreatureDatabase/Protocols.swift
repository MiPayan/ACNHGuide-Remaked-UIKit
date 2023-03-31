//
//  Protocols.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 21/02/2023.
//

import Foundation
import RealmSwift

protocol CreatureManaging {
    var realm: Realm { get }
    func getSavedCreatures<T: Object>(with creature: T.Type) -> [Object]
    func getCreature<T: Object>(with creature: T.Type, fileName: String) -> Object?
    func saveCreature(with object: Object)
    func deleteCreature(with object: Object)
}

protocol CreatureWriting {
    func saveCreature(fileName: String)
    func deleteCreature(fileName: String)
}

protocol CreaturePeeking {
    var creaturesSaved: [Object] { get }
    func isCreatureAlreadySaved(fileName: String) -> Bool
}
