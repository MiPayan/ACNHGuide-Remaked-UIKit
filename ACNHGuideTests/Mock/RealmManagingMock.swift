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
