//
//  FishCollectionViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import XCTest
@testable import ACNHGuide

final class FishCollectionViewCellViewModelTests: XCTestCase {
    
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatureWriterMock: CreatureWriterMock!
    private var fishCollectionViewCellViewModel: FishCollectionViewCellViewModel!
    
    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatureWriterMock = CreatureWriterMock()
        fishCollectionViewCellViewModel = FishCollectionViewCellViewModel(
            fishData: fishes[0],
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatureWriterMock
        )
    }
    
    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatureWriterMock = nil
        fishCollectionViewCellViewModel = nil
    }
    
    func testFileName() {
        guard let fileName = fishes.first?.fileName else {
            fatalError("Tests failed: testFileName() from FishCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(fileName, "bitterling")
        XCTAssertEqual(fishCollectionViewCellViewModel.fileName, "Bitterling")
    }
    
    func testIconURL() {
        guard let iconURI = fishes.first?.iconURI,
              let url = URL(string: iconURI) else {
            fatalError("Tests failed: testIconURL() from FishCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/fish/1")
        XCTAssertEqual(fishCollectionViewCellViewModel.iconURL, url)
    }
    
    func testIsFishAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let testFileName = "TestFilename"
        let isCreatureAlreadySaved = creaturePeekerMock.isCreatureAlreadySaved(fileName: testFileName)
        XCTAssertEqual(isCreatureAlreadySaved, false)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "TestFilename")
        XCTAssertEqual(fishCollectionViewCellViewModel.isFishAlreadySaved, false)
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
        XCTAssertEqual(fishCollectionViewCellViewModel.toggleSavedFish(), true)
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
        XCTAssertEqual(fishCollectionViewCellViewModel.toggleSavedFish(), false)
    }
}
