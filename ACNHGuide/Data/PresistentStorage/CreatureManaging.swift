//
//  CreatureManaging.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/07/2023.
//

import Foundation
import RealmSwift

protocol CreatureManaging {
    func getSavedCreatures<T: Object>(with creature: T.Type) -> [Object]
    func getCreature<T: Object>(with creature: T.Type, fileName: String) -> Object?
    func saveCreature(with object: Object, completionHandler: @escaping (Error) -> Void)
    func deleteCreature(with object: Object, completionHandler: @escaping (Error) -> Void)
}
