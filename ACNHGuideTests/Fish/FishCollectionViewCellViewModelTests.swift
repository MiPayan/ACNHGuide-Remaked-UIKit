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
        let isFishAlreadySaved = fishCollectionViewCellViewModel.isFishAlreadySaved
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "Bitterling")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(isFishAlreadySaved, false)
    }

    func testToggleSavedFishWhenIsNotAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let toggleSaved = fishCollectionViewCellViewModel.toggleSavedFish()
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureParameter, "Bitterling")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureCount, 1)
        XCTAssertEqual(toggleSaved, true)
    }
    
    func testToggleSavedFishWhenIsAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = true
        let toggleSaved = fishCollectionViewCellViewModel.toggleSavedFish()
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureParameter, "Bitterling")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureCount, 1)
        XCTAssertEqual(toggleSaved, false)
    }
}
