//
//  SeaCreature.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 15/02/2023.
//

import Foundation
import RealmSwift

final class SeaCreature: Object {
    
    @Persisted var fileName = ""
    
    convenience init(fileName: String) {
        self.init()
        self.fileName = fileName
    }
}
