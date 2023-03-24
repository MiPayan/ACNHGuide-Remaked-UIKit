//
//  RealmManagingMock.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 03/03/2023.
//

import RealmSwift
@testable import ACNHGuide

final class RealmManagingMock: RealmManaging {

    var invokedRealmCount = 0
    var stubbedRealm: Realm!

    var realm: Realm {
        invokedRealmCount += 1
        return stubbedRealm
    }
    
    var stubbedGetSavedCreatures: [Object]!
    var invokedGetSavedCreaturesCount = 0
    
    func getSavedCreatures<T: Object>(with creature: T.Type) -> [Object] {
        invokedGetSavedCreaturesCount += 1
        return stubbedGetSavedCreatures
    }
    
    var stubbedGetCreature: Object?
    var invokedGetCreaturetCount = 0
    var invokedFileNameGetCreatureParameter: String!
    
    func getCreature<T: Object>(with creature: T.Type, fileName: String) -> Object? {
        invokedGetCreaturetCount += 1
        invokedFileNameGetCreatureParameter = fileName
        return stubbedGetCreature
    }
    
    var invokedSavedObjectCount = 0
    var invokedSavedObjectParameter: Object?
    
    func saveObject(with object: Object) {
        invokedSavedObjectCount += 1
        invokedSavedObjectParameter = object
    }
    
    var invokedDeleteObjectCount = 0
    var invokedDeleteObjectParameter: Object?
    
    func deleteObject(with object: Object) {
        invokedDeleteObjectCount += 1
        invokedDeleteObjectParameter = object
    }
}
