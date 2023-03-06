//
//  SeaCreatureCollectionViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import XCTest
@testable import ACNHGuide

final class SeaCreatureCollectionViewCellViewModelTests: XCTestCase {
    
    private var seaCreatureCollectionViewCellViewModel: SeaCreatureCollectionViewCellViewModel!
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatureWriterMock: CreatureWriterMock!
    
    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatureWriterMock = CreatureWriterMock()
        seaCreatureCollectionViewCellViewModel = SeaCreatureCollectionViewCellViewModel(
            seaCreatureData: seaCreatures[0],
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatureWriterMock
        )
    }    
    
    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatureWriterMock = nil
        seaCreatureCollectionViewCellViewModel = nil
    }
    
    func testFileName() {
        guard let fileName = seaCreatures.first?.fileName else {
            fatalError("Tests failed: testFileName() from FishCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(fileName, "seaweed")
        XCTAssertEqual(seaCreatureCollectionViewCellViewModel.fileName, "Seaweed")
    }
    
    func testIconURL() {
        guard let iconURI = seaCreatures.first?.iconURI,
              let url = URL(string: iconURI) else {
            fatalError("Tests failed: testIconURL() from FishCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/sea/1")
        XCTAssertEqual(seaCreatureCollectionViewCellViewModel.iconURL, url)
    }
    
    func testIsSeaCreatureAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = true
        let testFileName = "TestFilename"
        let isCreatureAlreadySaved = creaturePeekerMock.isCreatureAlreadySaved(fileName: testFileName)
        XCTAssertEqual(isCreatureAlreadySaved, true)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "TestFilename")
        XCTAssertEqual(seaCreatureCollectionViewCellViewModel.isSeaCreatureAlreadySaved, true)
    }
    
    func testToggleSeaCreatureWhenIsNotAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let testFileName = "TestFileName"
        let isCreatureAlreadySaved = creaturePeekerMock.isCreatureAlreadySaved(fileName: testFileName)
        creatureWriterMock.saveCreature(fileName: testFileName)
        XCTAssertEqual(isCreatureAlreadySaved, false)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "TestFileName")
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureParameter, "TestFileName")
        XCTAssertEqual(seaCreatureCollectionViewCellViewModel.toggleSavedSeaCreature(), true)
    }
    
    func testToggleSeaCreatureWhenIsAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = true
        let testFileName = "TestFileName"
        let isCreatureAlreadySaved = creaturePeekerMock.isCreatureAlreadySaved(fileName: testFileName)
        creatureWriterMock.deleteCreature(fileName: testFileName)
        XCTAssertEqual(isCreatureAlreadySaved, true)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "TestFileName")
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureParameter, "TestFileName")
        XCTAssertEqual(seaCreatureCollectionViewCellViewModel.toggleSavedSeaCreature(), false)
    }
}
