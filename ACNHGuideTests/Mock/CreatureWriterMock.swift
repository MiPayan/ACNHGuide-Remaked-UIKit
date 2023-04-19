//
//  CreatureWriterMock.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 01/03/2023.
//

import RealmSwift
@testable import ACNHGuide

final class CreatureWriterMock: CreatureWriting {
    
    var invokedSaveCreatureCount = 0
    var invokedSaveCreatureParameter: String?
    var stubbedSaveCreatureCompletionHandlerError: Error?
    func saveCreature(fileName: String, completionHandler: @escaping (Error) -> Void) {
        invokedSaveCreatureCount += 1
        invokedSaveCreatureParameter = fileName
        if let error = stubbedSaveCreatureCompletionHandlerError {
            completionHandler(error)
        }
    }
    
    var invokedDeleteCreatureCount = 0
    var invokedDeleteCreatureParameter: String?
    var stubbedDeleteCreatureCompletionHandlerError: Error?
    func deleteCreature(fileName: String, completionHandler: @escaping (Error) -> Void) {
        invokedDeleteCreatureCount += 1
        invokedDeleteCreatureParameter = fileName
        if let error = stubbedSaveCreatureCompletionHandlerError {
            completionHandler(error)
        }
    }
}
