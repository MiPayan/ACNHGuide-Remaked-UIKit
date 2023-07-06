//
//  CreatureManagingMock.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 03/03/2023.
//

@testable import ACNHGuide
import RealmSwift

final class CreatureManagingMock: CreatureManaging {
    
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
    var stubbedSaveCreatureCompletionHandlerError: Error?
    
    func saveCreature(with object: Object, completionHandler: @escaping (Error) -> Void) {
        invokedSavedObjectCount += 1
        invokedSavedObjectParameter = object
        if let error = stubbedSaveCreatureCompletionHandlerError {
            completionHandler(error)
        }
    }
    
    var invokedDeleteObjectCount = 0
    var invokedDeleteObjectParameter: Object?
    var stubbedDeleteCreatureCompletionHandlerError: Error?
    
    func deleteCreature(with object: Object, completionHandler: @escaping (Error) -> Void) {
        invokedDeleteObjectCount += 1
        invokedDeleteObjectParameter = object
        if let error = stubbedDeleteCreatureCompletionHandlerError {
            completionHandler(error)
        }
    }
}
