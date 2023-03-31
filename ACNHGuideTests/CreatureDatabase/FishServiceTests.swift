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
        XCTAssertEqual(fishService.creaturesSaved.count, 2)
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
    
    func testSaveCreature() {
        let fileName = "fileName"
        fishService.saveCreature(fileName: fileName)
        XCTAssertEqual(creatureManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedSavedObjectParameter is Fish, true)
        XCTAssertEqual((creatureManagingMock.invokedSavedObjectParameter as! Fish).fileName, "fileName")
    }
    
    func testDeleteCreature() {
        let fish = Fish()
        let fileName = "fileName"
        fish.fileName = fileName
        creatureManagingMock.stubbedGetCreature = fish
        
        fishService.deleteCreature(fileName: fileName)
        XCTAssertEqual(creatureManagingMock.invokedDeleteObjectCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedDeleteObjectParameter is Fish, true)
        XCTAssertEqual((creatureManagingMock.invokedDeleteObjectParameter as! Fish).fileName, fileName)
        XCTAssertEqual(creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedFileNameGetCreatureParameter, "fileName")
    }
}
