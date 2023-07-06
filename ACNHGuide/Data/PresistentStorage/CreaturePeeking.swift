//
//  CreaturePeeking.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/07/2023.
//

import Foundation
import RealmSwift

protocol CreaturePeeking {
    var creaturesSaved: [Object] { get }
    func isCreatureAlreadySaved(fileName: String) -> Bool
}
