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
        let seaCreatureSavedCount = seaCreatureService.creaturesSaved.count
        XCTAssertEqual(seaCreatureSavedCount, 3)
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
        creatureManagingMock.stubbedSaveCreatureCompletionHandlerError = nil
        
        seaCreatureService.saveCreature(fileName: fileName) { error in
            XCTAssertNil(error)
        }
        
        XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectParameter is SeaCreature, true)
        XCTAssertEqual((self.creatureManagingMock.invokedSavedObjectParameter as! SeaCreature).fileName, fileName)
    }
    
    func testSaveCreatureCompletionHandlerError() {
          let fileName = "fileName"
          creatureManagingMock.stubbedSaveCreatureCompletionHandlerError = NSError(domain: "SaveCreatureCompletionHandler", code: 1)
          
          seaCreatureService.saveCreature(fileName: fileName) { error in
              XCTAssertNotNil(error)
          }
          
          XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectCount, 1)
          XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectParameter is SeaCreature, true)
          XCTAssertEqual((self.creatureManagingMock.invokedSavedObjectParameter as! SeaCreature).fileName, "fileName")
      }
    
    func testDeleteCreature() {
        let seaCreature = SeaCreature()
        let fileName = "fileName"
        seaCreature.fileName = fileName
        creatureManagingMock.stubbedGetCreature = seaCreature
        creatureManagingMock.stubbedDeleteCreatureCompletionHandlerError = nil
        
        seaCreatureService.deleteCreature(fileName: fileName) { error in
            XCTAssertNil(error)
        }
        XCTAssertEqual(self.creatureManagingMock.invokedDeleteObjectCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedDeleteObjectParameter is SeaCreature, true)
        XCTAssertEqual((self.creatureManagingMock.invokedDeleteObjectParameter as! SeaCreature).fileName, fileName)
        XCTAssertEqual(creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedFileNameGetCreatureParameter, "fileName")
    }
    
    func testDeleteCreatureCompletionHandlerError() {
        let seaCreature = SeaCreature()
        let fileName = "fileName"
        seaCreature.fileName = fileName
        creatureManagingMock.stubbedGetCreature = seaCreature
        creatureManagingMock.stubbedDeleteCreatureCompletionHandlerError = NSError(domain: "DeleteCreatureCompletionHandler", code: 1)
        
        seaCreatureService.deleteCreature(fileName: fileName) { error in
            XCTAssertNotNil(error)
        }
        
        XCTAssertEqual(self.creatureManagingMock.invokedDeleteObjectCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedDeleteObjectParameter is SeaCreature, true)
        XCTAssertEqual((self.creatureManagingMock.invokedDeleteObjectParameter as! SeaCreature).fileName, fileName)
        XCTAssertEqual(self.creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedFileNameGetCreatureParameter, "fileName")
    }
}
