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
    
    func testFileName() {
        guard let filename = fossils.first?.fileName else {
            fatalError("Tests failed: testFileName() from FossilCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(filename, "acanthostega")
        XCTAssertEqual(fossilCollectionViewCellViewModel.fileName, "Acanthostega")
    }
    
    func testImageURL() {
        guard let imageURI = fossils.first?.imageURI,
              let url = URL(string: imageURI) else {
            fatalError("Tests failed: testImageURL() from FossilCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(imageURI, "https://acnhapi.com/v1/images/fossils/acanthostega")
        XCTAssertEqual(fossilCollectionViewCellViewModel.imageURL, url)
    }
    
    func testToggleSeaCreature() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let isSaved = fossilCollectionViewCellViewModel.toggleSavedFossil()
        XCTAssertEqual(1, creaturePeekerMock.invokedIsCreatureAlreadySaved)
        XCTAssertEqual(1, creatureWriterMock.invokedSaveCreatureCount)
        XCTAssertEqual(true, isSaved)
    }
}
