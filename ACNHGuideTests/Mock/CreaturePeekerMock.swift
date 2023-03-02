//
//  CreaturePeekerMock.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import Foundation
import RealmSwift
@testable import ACNHGuide

final class CreaturePeekerMock: CreaturePeeking {
    
    var invokedCreatureSavedCount = 0
    var stubbedFishesSaved: [Fish]!
    
    var creaturesSaved: [Object] {
        invokedCreatureSavedCount += 1
        return stubbedFishesSaved
    }
    
    var invokedIsCreatureAlreadySaved = 0
    var invokedIsCreatureAlreadySavedParameter: String?
    var stubbedIsCreatureAlreadySaved: Bool!
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        invokedIsCreatureAlreadySaved += 1
        invokedIsCreatureAlreadySavedParameter = fileName
        return stubbedIsCreatureAlreadySaved
    }
}
