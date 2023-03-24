//
//  SeaCreatureServiceTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 23/03/2023.
//

import XCTest
@testable import ACNHGuide

final class SeaCreatureServiceTests: XCTestCase {

    private var realmManagingMock: RealmManagingMock!
    private var seaCreatureService: SeaCreatureService!

    override func setUpWithError() throws {
        realmManagingMock = RealmManagingMock()
        seaCreatureService = SeaCreatureService(realmManager: realmManagingMock)
    }

    override func tearDownWithError() throws {
        realmManagingMock = nil
        seaCreatureService = nil
    }

    func testCreaturesSaved() {
        realmManagingMock.stubbedGetSavedCreatures = [SeaCreature(), SeaCreature(), SeaCreature()]
        XCTAssertEqual(seaCreatureService.creaturesSaved.count, 3)
        XCTAssertEqual(realmManagingMock.invokedGetSavedCreaturesCount, 1)
    }
    
    func testIsNotCreatureAlreadySaved() {
        realmManagingMock.stubbedGetCreature = nil
        let fileName = "fileName"
        let isAlreadySaved = seaCreatureService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, false)
        XCTAssertEqual(realmManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(realmManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testCreatureAlreadySaved() {
        realmManagingMock.stubbedGetCreature = SeaCreature()
        let fileName = "fileName"
        let isAlreadySaved = seaCreatureService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, true)
        XCTAssertEqual(realmManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(realmManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }

    func testSaveCreature() {
        let fileName = "fileName"
        seaCreatureService.saveCreature(fileName: fileName)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectParameter is SeaCreature, true)
        XCTAssertEqual((realmManagingMock.invokedSavedObjectParameter as! SeaCreature).fileName, fileName)
    }

    func testDeleteCreature() {
        let seaCreature = SeaCreature()
        let fileName = "fileName"
        realmManagingMock.stubbedGetCreature = seaCreature
        seaCreature.fileName = fileName

        seaCreatureService.saveCreature(fileName: fileName)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectParameter is SeaCreature, true)
        XCTAssertEqual((realmManagingMock.invokedSavedObjectParameter as! SeaCreature).fileName, fileName)

        seaCreatureService.deleteCreature(fileName: fileName)
        XCTAssertEqual(realmManagingMock.invokedDeleteObjectCount, 1)
        XCTAssertEqual(realmManagingMock.invokedDeleteObjectParameter is SeaCreature, true)
        XCTAssertEqual((realmManagingMock.invokedDeleteObjectParameter as! SeaCreature).fileName, fileName)
        XCTAssertEqual(realmManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(realmManagingMock.invokedFileNameGetCreatureParameter, "fileName")
    }
}
