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
    var invokedCompletionHandlerParameter: Error!
    func saveCreature(fileName: String, completionHandler: @escaping (Error) -> Void) {
        invokedSaveCreatureCount += 1
        invokedSaveCreatureParameter = fileName
    }
    
    var invokedDeleteCreatureCount = 0
    var invokedDeleteCreatureParameter: String?
    func deleteCreature(fileName: String, completionHandler: @escaping (Error) -> Void) {
        invokedDeleteCreatureCount += 1
        invokedDeleteCreatureParameter = fileName
    }
}
