//
//  CreaturePeekerMock.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import RealmSwift
@testable import ACNHGuide

final class CreaturePeekerMock: CreaturePeeking {
    
    var invokedCreatureSavedCount = 0
    var stubbedCreaturesSaved: [Object]!
    
    var creaturesSaved: [Object] {
        invokedCreatureSavedCount += 1
        return stubbedCreaturesSaved
    }
    
    var invokedIsCreatureAlreadySavedCount = 0
    var invokedIsCreatureAlreadySavedParameter: String?
    var stubbedIsCreatureAlreadySaved: Bool!
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        invokedIsCreatureAlreadySavedCount += 1
        invokedIsCreatureAlreadySavedParameter = fileName
        return stubbedIsCreatureAlreadySaved
    }
}
