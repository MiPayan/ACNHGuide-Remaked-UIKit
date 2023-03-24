//
//  FossilServiceTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 23/03/2023.
//

import XCTest
@testable import ACNHGuide

final class FossilServiceTests: XCTestCase {

    private var realmManagingMock: RealmManagingMock!
    private var fossilService: FossilService!
    
    override func setUpWithError() throws {
        realmManagingMock = RealmManagingMock()
        fossilService = FossilService(realmManager: realmManagingMock)
    }
    
    override func tearDownWithError() throws {
        realmManagingMock = nil
        fossilService = nil
    }
    
    func testCreaturesSaved() {
        realmManagingMock.stubbedGetSavedCreatures = []
        XCTAssertEqual(fossilService.creaturesSaved.count, 0)
        XCTAssertEqual(realmManagingMock.invokedGetSavedCreaturesCount, 1)
    }
    
    func testIsNotCreatureAlreadySaved() {
        realmManagingMock.stubbedGetCreature = nil
        let fileName = "fileName"
        let isAlreadySaved = fossilService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, false)
        XCTAssertEqual(realmManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(realmManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testCreatureAlreadySaved() {
        realmManagingMock.stubbedGetCreature = Fossil()
        let fileName = "fileName"
        let isAlreadySaved = fossilService.isCreatureAlreadySaved(fileName: fileName)
        XCTAssertEqual(isAlreadySaved, true)
        XCTAssertEqual(realmManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(realmManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testSaveCreature() {
        let fileName = "fileName"
        fossilService.saveCreature(fileName: fileName)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectParameter is Fossil, true)
        XCTAssertEqual((realmManagingMock.invokedSavedObjectParameter as! Fossil).fileName, fileName)
    }
    
    func testDeleteCreature() {
        let fossil = Fossil()
        let fileName = "fileName"
        realmManagingMock.stubbedGetCreature = fossil
        fossil.fileName = fileName
        
        fossilService.saveCreature(fileName: fileName)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectParameter is Fossil, true)
        XCTAssertEqual((realmManagingMock.invokedSavedObjectParameter as! Fossil).fileName, fileName)
        
        fossilService.deleteCreature(fileName: fileName)
        XCTAssertEqual(realmManagingMock.invokedDeleteObjectCount, 1)
        XCTAssertEqual(realmManagingMock.invokedDeleteObjectParameter is Fossil, true)
        XCTAssertEqual((realmManagingMock.invokedDeleteObjectParameter as! Fossil).fileName, fileName)
        XCTAssertEqual(realmManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(realmManagingMock.invokedFileNameGetCreatureParameter, "fileName")
    }
}
