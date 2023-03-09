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

    }
    
    func testIsCreatureAlreadySaved() {
        
    }
    
    func testSaveCreature() {
        let fish = Fish()
        let fileName = "TestFileName"
        fish.fileName = fileName
        
        fishService.saveCreature(fileName: fileName)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(realmManagingMock.invokedSavedObjectParameter is Fish, true)
        XCTAssertEqual((realmManagingMock.invokedSavedObjectParameter as! Fish).fileName, fileName)
    }
    
    func testDeleteCreature() {
        
    }
}
