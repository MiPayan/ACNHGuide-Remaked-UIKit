//
//  BugServiceTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 23/03/2023.
//

import XCTest
@testable import ACNHGuide

final class BugServiceTests: XCTestCase {
    
    private var realmManagingMock: RealmManagingMock!
    private var bugService: BugService!
    
    override func setUpWithError() throws {
        realmManagingMock = RealmManagingMock()
        bugService = BugService(realmManager: realmManagingMock)
    }
    
    override func tearDownWithError() throws {
        realmManagingMock = nil
        bugService = nil
    }
    
    func testCreaturesSaved() {
        realmManagingMock.stubbedGetSavedCreatures = [Bug()]
        XCTAssertEqual(bugService.creaturesSaved.count, 1)
        XCTAssertEqual(realmManagingMock.invokedGetSavedCreaturesCount, 1)
    }
    
    func testIsNotCreatureAlreadySaved() {
        realmManagingMock.stubbedGetCreature = nil
        let fileName = "fileName"
        let isAlreadySaved = bugService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, false)
        XCTAssertEqual(realmManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(realmManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testCreatureAlreadySaved() {
        realmManagingMock.stubbedGetCreature = Bug()
        let fileName = "fileName"
        let isAlreadySaved = bugService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, true)
        XCTAssertEqual(realmManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(realmManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testSaveCreature() {
        let fileName = "fileName"
        bugService.saveCreature(fileName: fileName)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectParameter is Bug, true)
        XCTAssertEqual((realmManagingMock.invokedSavedObjectParameter as! Bug).fileName, fileName)
    }
    
    func testDeleteCreature() {
        let bug = Bug()
        let fileName = "fileName"
        realmManagingMock.stubbedGetCreature = bug
        bug.fileName = fileName
        
        bugService.saveCreature(fileName: fileName)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectParameter is Bug, true)
        XCTAssertEqual((realmManagingMock.invokedSavedObjectParameter as! Bug).fileName, fileName)
        
        bugService.deleteCreature(fileName: fileName)
        XCTAssertEqual(realmManagingMock.invokedDeleteObjectCount, 1)
        XCTAssertEqual(realmManagingMock.invokedDeleteObjectParameter is Bug, true)
        XCTAssertEqual((realmManagingMock.invokedDeleteObjectParameter as! Bug).fileName, fileName)
        XCTAssertEqual(realmManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(realmManagingMock.invokedFileNameGetCreatureParameter, "fileName")
    }
}
