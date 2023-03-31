//
//  SeaCreatureServiceTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 23/03/2023.
//

import XCTest
@testable import ACNHGuide

final class SeaCreatureServiceTests: XCTestCase {

    private var creatureManagingMock: CreatureManagingMock!
    private var seaCreatureService: SeaCreatureService!

    override func setUpWithError() throws {
        creatureManagingMock = CreatureManagingMock()
        seaCreatureService = SeaCreatureService(creatureManager: creatureManagingMock)
    }

    override func tearDownWithError() throws {
        creatureManagingMock = nil
        seaCreatureService = nil
    }

    func testCreaturesSaved() {
        creatureManagingMock.stubbedGetSavedCreatures = [SeaCreature(), SeaCreature(), SeaCreature()]
        XCTAssertEqual(seaCreatureService.creaturesSaved.count, 3)
        XCTAssertEqual(creatureManagingMock.invokedGetSavedCreaturesCount, 1)
    }
    
    func testIsNotCreatureAlreadySaved() {
        creatureManagingMock.stubbedGetCreature = nil
        let fileName = "fileName"
        let isAlreadySaved = seaCreatureService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, false)
        XCTAssertEqual(creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testIsCreatureAlreadySaved() {
        creatureManagingMock.stubbedGetCreature = SeaCreature()
        let fileName = "fileName"
        let isAlreadySaved = seaCreatureService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, true)
        XCTAssertEqual(creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }

    func testSaveCreature() {
        let fileName = "fileName"
        seaCreatureService.saveCreature(fileName: fileName)
        XCTAssertEqual(creatureManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedSavedObjectParameter is SeaCreature, true)
        XCTAssertEqual((creatureManagingMock.invokedSavedObjectParameter as! SeaCreature).fileName, fileName)
    }

    func testDeleteCreature() {
        let seaCreature = SeaCreature()
        let fileName = "fileName"
        creatureManagingMock.stubbedGetCreature = seaCreature
        seaCreature.fileName = fileName

        seaCreatureService.saveCreature(fileName: fileName)
        XCTAssertEqual(creatureManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedSavedObjectParameter is SeaCreature, true)
        XCTAssertEqual((creatureManagingMock.invokedSavedObjectParameter as! SeaCreature).fileName, fileName)

        seaCreatureService.deleteCreature(fileName: fileName)
        XCTAssertEqual(creatureManagingMock.invokedDeleteObjectCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedDeleteObjectParameter is SeaCreature, true)
        XCTAssertEqual((creatureManagingMock.invokedDeleteObjectParameter as! SeaCreature).fileName, fileName)
        XCTAssertEqual(creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedFileNameGetCreatureParameter, "fileName")
    }
}
