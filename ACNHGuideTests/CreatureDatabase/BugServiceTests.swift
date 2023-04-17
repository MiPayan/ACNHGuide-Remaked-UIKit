//
//  BugServiceTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 23/03/2023.
//

import XCTest
@testable import ACNHGuide

final class BugServiceTests: XCTestCase {
    
    private var creatureManagingMock: CreatureManagingMock!
    private var bugService: BugService!
    
    override func setUpWithError() throws {
        creatureManagingMock = CreatureManagingMock()
        bugService = BugService(creatureManager: creatureManagingMock)
    }
    
    override func tearDownWithError() throws {
        creatureManagingMock = nil
        bugService = nil
    }
    
    func testCreaturesSaved() {
        creatureManagingMock.stubbedGetSavedCreatures = [Bug()]
        let bugSavedCount = bugService.creaturesSaved.count
        XCTAssertEqual(bugSavedCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedGetSavedCreaturesCount, 1)
    }
    
    func testIsNotCreatureAlreadySaved() {
        creatureManagingMock.stubbedGetCreature = nil
        let fileName = "fileName"
        let isAlreadySaved = bugService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, false)
        XCTAssertEqual(creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testIsCreatureAlreadySaved() {
        creatureManagingMock.stubbedGetCreature = Bug()
        let fileName = "fileName"
        let isAlreadySaved = bugService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, true)
        XCTAssertEqual(creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testSaveCreature() {
        let fileName = "fileName"
        bugService.saveCreature(fileName: fileName) {_ in }
        XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectParameter is Bug, true)
        XCTAssertEqual((self.creatureManagingMock.invokedSavedObjectParameter as! Bug).fileName, fileName)
    }
    
    func testDeleteCreature() {
        let bug = Bug()
        let fileName = "fileName"
        creatureManagingMock.stubbedGetCreature = bug
        bug.fileName = fileName
        
        bugService.deleteCreature(fileName: fileName) {_ in }
        XCTAssertEqual(self.creatureManagingMock.invokedDeleteObjectCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedDeleteObjectParameter is Bug, true)
        XCTAssertEqual((self.creatureManagingMock.invokedDeleteObjectParameter as! Bug).fileName, fileName)
        XCTAssertEqual(creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedFileNameGetCreatureParameter, "fileName")
    }
}
