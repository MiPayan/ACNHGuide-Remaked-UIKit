//
//  Protocols.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 21/02/2023.
//

import Foundation
import RealmSwift

protocol CreatureWriting {
    func saveCreature(fileName: String)
    func deleteCreature(fileName: String)
}

protocol CreaturePeeking {
    func isCreatureAlreadySaved(fileName: String) -> Bool
}
