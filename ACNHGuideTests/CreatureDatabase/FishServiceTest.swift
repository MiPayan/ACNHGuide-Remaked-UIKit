//
//  FishServiceTest.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 07/03/2023.
//

import XCTest
import RealmSwift
@testable import ACNHGuide

final class FishServiceTest: XCTestCase {
    
    private var realmManagingMock: RealmManagingMock!
    private var fishService: FishService!
    
    override func setUpWithError() throws {
        realmManagingMock = RealmManagingMock()
        fishService = FishService(realmManager: realmManagingMock)
    }
    
    override func tearDownWithError() throws {
        realmManagingMock = nil
        fishService = nil
    }
    
    func testCreaturesSaved() {
        realmManagingMock.stubbedGetSavedCreatures = [Fish(), Fish()]
        XCTAssertEqual(fishService.creaturesSaved.count, 2)
        XCTAssertEqual(realmManagingMock.invokedGetSavedCreaturesCount, 1)
    }
    
    func testIsNotCreatureAlreadySaved() {
        realmManagingMock.stubbedGetCreature = nil
        let fileName = "fileName"
        let isAlreadySaved = fishService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, false)
        XCTAssertEqual(realmManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(realmManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testCreatureAlreadySaved() {
        realmManagingMock.stubbedGetCreature = Fish()
        let fileName = "fileName"
        let isAlreadySaved = fishService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, true)
        XCTAssertEqual(realmManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(realmManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testSaveCreature() {
        let fileName = "fileName"
        fishService.saveCreature(fileName: fileName)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectParameter is Fish, true)
        XCTAssertEqual((realmManagingMock.invokedSavedObjectParameter as! Fish).fileName, "fileName")
    }
    
    func testDeleteCreature() {
        let fish = Fish()
        let fileName = "fileName"
        fish.fileName = fileName
        realmManagingMock.stubbedGetCreature = fish
        
        fishService.deleteCreature(fileName: fileName)
        XCTAssertEqual(realmManagingMock.invokedDeleteObjectCount, 1)
        XCTAssertEqual(realmManagingMock.invokedDeleteObjectParameter is Fish, true)
        XCTAssertEqual((realmManagingMock.invokedDeleteObjectParameter as! Fish).fileName, fileName)
        XCTAssertEqual(realmManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(realmManagingMock.invokedFileNameGetCreatureParameter, "fileName")
    }
}
