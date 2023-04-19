//
//  FishServiceTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 07/03/2023.
//

import XCTest
@testable import ACNHGuide

final class FishServiceTests: XCTestCase {
    
    private var creatureManagingMock: CreatureManagingMock!
    private var fishService: FishService!
    
    override func setUpWithError() throws {
        creatureManagingMock = CreatureManagingMock()
        fishService = FishService(creatureManager: creatureManagingMock)
    }
    
    override func tearDownWithError() throws {
        creatureManagingMock = nil
        fishService = nil
    }
    
    func testCreaturesSaved() {
        creatureManagingMock.stubbedGetSavedCreatures = [Fish(), Fish()]
        let fishSavedCount = fishService.creaturesSaved.count
        XCTAssertEqual(fishSavedCount, 2)
        XCTAssertEqual(creatureManagingMock.invokedGetSavedCreaturesCount, 1)
    }
    
    func testIsNotCreatureAlreadySaved() {
        creatureManagingMock.stubbedGetCreature = nil
        let fileName = "fileName"
        let isAlreadySaved = fishService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, false)
        XCTAssertEqual(creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testIsCreatureAlreadySaved() {
        creatureManagingMock.stubbedGetCreature = Fish()
        let fileName = "fileName"
        let isAlreadySaved = fishService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, true)
        XCTAssertEqual(creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testSaveCreatureSuccess() {
        let fileName = "fileName"
        creatureManagingMock.stubbedSaveCreatureCompletionHandlerError = nil
        
        fishService.saveCreature(fileName: fileName) { error in
            XCTAssertNil(error)
        }
        
        XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectParameter is Fish, true)
        XCTAssertEqual((self.creatureManagingMock.invokedSavedObjectParameter as! Fish).fileName, "fileName")
    }
    
    func testSaveCreatureCompletionHandlerError() {
        let fileName = "fileName"
        creatureManagingMock.stubbedSaveCreatureCompletionHandlerError = NSError(domain: "SaveCreatureCompletionHandler", code: 1)
        
        fishService.saveCreature(fileName: fileName) { error in
            XCTAssertNotNil(error)
        }
        
        XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectParameter is Fish, true)
        XCTAssertEqual((self.creatureManagingMock.invokedSavedObjectParameter as! Fish).fileName, "fileName")
    }
    
    func testDeleteCreatureSuccess() {
        let fish = Fish()
        let fileName = "fileName"
        fish.fileName = fileName
        creatureManagingMock.stubbedGetCreature = fish
        creatureManagingMock.stubbedDeleteCreatureCompletionHandlerError = nil
        
        fishService.deleteCreature(fileName: fileName) { error in
            XCTAssertNil(error)
        }
        
        XCTAssertEqual(self.creatureManagingMock.invokedDeleteObjectCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedDeleteObjectParameter is Fish, true)
        XCTAssertEqual((self.creatureManagingMock.invokedDeleteObjectParameter as! Fish).fileName, fileName)
        XCTAssertEqual(self.creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedFileNameGetCreatureParameter, "fileName")
    }
    
    func testDeleteCreatureCompletionHandlerError() {
        let fish = Fish()
        let fileName = "fileName"
        fish.fileName = fileName
        creatureManagingMock.stubbedGetCreature = fish
        creatureManagingMock.stubbedDeleteCreatureCompletionHandlerError = NSError(domain: "DeleteCreatureCompletionHandler", code: 1)

        fishService.deleteCreature(fileName: fileName) { error in
            XCTAssertNotNil(error)
        }

        XCTAssertEqual(creatureManagingMock.invokedDeleteObjectCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedDeleteObjectParameter is Fish, true)
        XCTAssertEqual((creatureManagingMock.invokedDeleteObjectParameter as! Fish).fileName, fileName)
        XCTAssertEqual(self.creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedFileNameGetCreatureParameter, "fileName")
    }
}
