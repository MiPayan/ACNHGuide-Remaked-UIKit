//
//  FossilCollectionViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 17/02/2023.
//

import XCTest
@testable import ACNHGuide

final class FossilCollectionViewCellViewModelTests: XCTestCase {
    
    private var fossilCollectionViewCellViewModel: FossilCollectionViewCellViewModel!
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatureWriterMock: CreatureWriterMock!
    
    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatureWriterMock = CreatureWriterMock()
        fossilCollectionViewCellViewModel = FossilCollectionViewCellViewModel(
            fossilData: fossils[0],
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatureWriterMock
        )
    }
      
    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatureWriterMock = nil
        fossilCollectionViewCellViewModel = nil
    }
    
    func testFileName() throws {
        let fileName = try XCTUnwrap(fossils.first?.fileName, "Tests failed: testFileName() from FossilCollectionViewCellViewModelTests")
        XCTAssertEqual(fileName, "acanthostega")
        XCTAssertEqual(fossilCollectionViewCellViewModel.fileName, "Acanthostega")
    }
    
    func testImageURL() throws {
        let imageURI = try XCTUnwrap(fossils.first?.imageURI, "Tests failed: testImageURL() from FossilCollectionViewCellViewModelTests")
        let url = URL(string: imageURI)
        XCTAssertEqual(imageURI, "https://acnhapi.com/v1/images/fossils/acanthostega")
        XCTAssertEqual(fossilCollectionViewCellViewModel.imageURL, url)
    }
    
    func testIsFossilAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let isFossilAlreadySaved = fossilCollectionViewCellViewModel.isFossilAlreadySaved
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "Acanthostega")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(isFossilAlreadySaved, false)
    }
    
    func testToggleSavedFossilWhenIsNotAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let toggleSaved = fossilCollectionViewCellViewModel.toggleSavedFossil()
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureParameter, "Acanthostega")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureCount, 1)
        XCTAssertEqual(toggleSaved, true)
    }
    
    func testToggleSavedFossilWhenIsAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = true
        let toggleSaved = fossilCollectionViewCellViewModel.toggleSavedFossil()
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureParameter, "Acanthostega")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureCount, 1)
        XCTAssertEqual(toggleSaved, false)
    }
}
