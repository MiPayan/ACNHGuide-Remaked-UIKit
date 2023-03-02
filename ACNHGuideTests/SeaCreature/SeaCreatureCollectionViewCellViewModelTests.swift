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
    private var creatueWriterMock: CreatureWriterMock!
    
    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatueWriterMock = CreatureWriterMock()
        seaCreatureCollectionViewCellViewModel = SeaCreatureCollectionViewCellViewModel(
            seaCreatureData: seaCreatures[0],
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatueWriterMock
        )
    }    
    
    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatueWriterMock = nil
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
    
    func testToggleSeaCreature() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let isSaved = seaCreatureCollectionViewCellViewModel.toggleSavedSeaCreature()
        XCTAssertEqual(1, creaturePeekerMock.invokedIsCreatureAlreadySaved)
        XCTAssertEqual(1, creatueWriterMock.invokedSaveCreatureCount)
        XCTAssertEqual(true, isSaved)
    }
}
