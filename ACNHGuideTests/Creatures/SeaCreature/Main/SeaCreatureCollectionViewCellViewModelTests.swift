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
    
    func testFileName() throws {
        let fileName = try XCTUnwrap(seaCreatures.first?.fileName, "Tests failed: testFileName() from SeaCreatureCollectionViewCellViewModelTests")
        XCTAssertEqual(fileName, "seaweed")
        XCTAssertEqual(seaCreatureCollectionViewCellViewModel.fileName, "Seaweed")
    }
    
    func testIconURL() throws {
        let iconURI = try XCTUnwrap(seaCreatures.first?.iconURI, "Tests failed: testIconURL() from SeaCreatureCollectionViewCellViewModelTests")
        let url = URL(string: iconURI)
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/sea/1")
        XCTAssertEqual(seaCreatureCollectionViewCellViewModel.iconURL, url)
    }
    
    func testIsSeaCreatureAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        
        let isSeaCreatureAlreadySaved = seaCreatureCollectionViewCellViewModel.isSeaCreatureAlreadySaved
        
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "Seaweed")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertFalse(isSeaCreatureAlreadySaved)
    }
    
    func testToggleSeaCreatureWhenIsNotAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        
        let isSaved = seaCreatureCollectionViewCellViewModel.toggleSavedSeaCreature()
        
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureParameter, "Seaweed")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureCount, 1)
        XCTAssertTrue(isSaved)
    }
    
    func testToggleSeaCreatureWhenIsAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = true
        
        let isSaved = seaCreatureCollectionViewCellViewModel.toggleSavedSeaCreature()
        
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureParameter, "Seaweed")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureCount, 1)
        XCTAssertFalse(isSaved)
    }
}
