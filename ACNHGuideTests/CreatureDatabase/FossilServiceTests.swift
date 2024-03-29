//
//  FossilServiceTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 23/03/2023.
//

import XCTest
@testable import ACNHGuide

final class FossilServiceTests: XCTestCase {
    
    private var creatureManagingMock: CreatureManagingMock!
    private var fossilService: FossilService!
    
    override func setUpWithError() throws {
        creatureManagingMock = CreatureManagingMock()
        fossilService = FossilService(creatureManager: creatureManagingMock)
    }
    
    override func tearDownWithError() throws {
        creatureManagingMock = nil
        fossilService = nil
    }
    
    func testCreaturesSaved() {
        creatureManagingMock.stubbedGetSavedCreatures = []
        
        let fossilSavedCount = fossilService.creaturesSaved.count
        
        XCTAssertEqual(fossilSavedCount, 0)
        XCTAssertEqual(creatureManagingMock.invokedGetSavedCreaturesCount, 1)
    }
    
    func testIsNotCreatureAlreadySaved() {
        creatureManagingMock.stubbedGetCreature = nil
        let fileName = "fileName"
        
        let isAlreadySaved = fossilService.isCreatureAlreadySaved(fileName: fileName)
        
        XCTAssertEqual(isAlreadySaved, false)
        XCTAssertEqual(creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testIsCreatureAlreadySaved() {
        creatureManagingMock.stubbedGetCreature = Fossil()
        let fileName = "fileName"
        
        let isAlreadySaved = fossilService.isCreatureAlreadySaved(fileName: fileName)
        
        XCTAssertEqual(isAlreadySaved, true)
        XCTAssertEqual(creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedFileNameGetCreatureParameter, fileName)
    }
    
    func testSaveCreature() {
        let fileName = "fileName"
        creatureManagingMock.stubbedSaveCreatureCompletionHandlerError = nil
        
        fossilService.saveCreature(fileName: fileName) { error in
            XCTAssertNil(error)
        }
        XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectParameter is Fossil, true)
        XCTAssertEqual((self.creatureManagingMock.invokedSavedObjectParameter as! Fossil).fileName, fileName)
    }
    
    func testSaveCreatureCompletionHandlerError() {
          let fileName = "fileName"
          creatureManagingMock.stubbedSaveCreatureCompletionHandlerError = NSError(domain: "SaveCreatureCompletionHandler", code: 1)
          
          fossilService.saveCreature(fileName: fileName) { error in
              XCTAssertNotNil(error)
          }
          
          XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectCount, 1)
          XCTAssertEqual(self.creatureManagingMock.invokedSavedObjectParameter is Fossil, true)
          XCTAssertEqual((self.creatureManagingMock.invokedSavedObjectParameter as! Fossil).fileName, "fileName")
      }

    func testDeleteCreature() {
        let fossil = Fossil()
        let fileName = "fileName"
        fossil.fileName = fileName
        creatureManagingMock.stubbedGetCreature = fossil
        creatureManagingMock.stubbedDeleteCreatureCompletionHandlerError = nil
        
        fossilService.deleteCreature(fileName: fileName) { error in
            XCTAssertNil(error)
        }
        XCTAssertEqual(self.creatureManagingMock.invokedDeleteObjectCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedDeleteObjectParameter is Fossil, true)
        XCTAssertEqual((self.creatureManagingMock.invokedDeleteObjectParameter as! Fossil).fileName, fileName)
        XCTAssertEqual(creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(creatureManagingMock.invokedFileNameGetCreatureParameter, "fileName")
    }
    
    func testDeleteCreatureCompletionHandlerError() {
        let fossil = Fossil()
        let fileName = "fileName"
        fossil.fileName = fileName
        creatureManagingMock.stubbedGetCreature = fossil
        creatureManagingMock.stubbedDeleteCreatureCompletionHandlerError = NSError(domain: "DeleteCreatureCompletionHandler", code: 1)
        
        fossilService.deleteCreature(fileName: fileName) { error in
            XCTAssertNotNil(error)
        }
        
        XCTAssertEqual(self.creatureManagingMock.invokedDeleteObjectCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedDeleteObjectParameter is Fossil, true)
        XCTAssertEqual((self.creatureManagingMock.invokedDeleteObjectParameter as! Fossil).fileName, fileName)
        XCTAssertEqual(self.creatureManagingMock.invokedGetCreaturetCount, 1)
        XCTAssertEqual(self.creatureManagingMock.invokedFileNameGetCreatureParameter, "fileName")
    }
    
}
