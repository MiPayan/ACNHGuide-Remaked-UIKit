//
//  FossilDetailsTableViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 01/02/2023.
//

import XCTest
@testable import ACNHGuide

final class FossilDetailsTableViewCellViewModelTests: XCTestCase {
    
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatureWriterMock: CreatureWriterMock!
    private var fossilDetailsTableViewCellViewModel: FossilDetailsTableViewCellViewModel!
    
    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatureWriterMock = CreatureWriterMock()
        fossilDetailsTableViewCellViewModel = FossilDetailsTableViewCellViewModel(
            fossilData: fossils[0],
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatureWriterMock
        )
    }
    
    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatureWriterMock = nil
        fossilDetailsTableViewCellViewModel = nil
    }
    
    func testFileName() {
        guard let fileName = fossils.first?.fileName else {
            fatalError("Tests failed: testFileName() from FossilDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(fileName, "acanthostega")
        XCTAssertEqual(fossilDetailsTableViewCellViewModel.fileName, "Acanthostega")
    }
    
    func testImageURL() {
        guard let imageURI = fossils.first?.imageURI,
              let url = URL(string: imageURI) else {
            fatalError("Tests failed: testImageURI() from FossilDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(imageURI, "https://acnhapi.com/v1/images/fossils/acanthostega")
        XCTAssertEqual(fossilDetailsTableViewCellViewModel.imageURL, url)
    }
    
    func testPrice() {
        guard let price = fossils.first?.price else {
            fatalError("Tests failed: testPrice() from FossilDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(price, 2000)
        XCTAssertEqual(fossilDetailsTableViewCellViewModel.price, "2000")
    }
    
    func testMuseumPhrase() {
        guard let museumPhrase = fossils.first?.museumPhrase else {
            fatalError("Tests failed: testMuseumPhrase() from FossilDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(museumPhrase, "The acanthostega! Said to be one of the earliest amphibians, it existed well before dinosaurs. Because they lived as fish not long before, they still had gills and very webbed \"hands.\". To toss away the life they knew and venture onto unknown lands... they must have been very brave! Hmm... Does it still count as bravery if you have no understanding of what you're doing?")
        XCTAssertEqual(fossilDetailsTableViewCellViewModel.museumPhrase, museumPhrase)
    }
        
    func testIsFossilAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let isFossilAlreadySaved = fossilDetailsTableViewCellViewModel.isFossilAlreadySaved
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "Acanthostega")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(isFossilAlreadySaved, false)
    }
    
    func testToggleSavedFossilWhenIsNotAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let toggleSaved = fossilDetailsTableViewCellViewModel.toggleSavedFossil()
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureParameter, "Acanthostega")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureCount, 1)
        XCTAssertEqual(toggleSaved, true)
    }
    
    func testToggleSavedFossilWhenIsAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = true
        let toggleSaved = fossilDetailsTableViewCellViewModel.toggleSavedFossil()
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureParameter, "Acanthostega")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureCount, 1)
        XCTAssertEqual(toggleSaved, false)
    }
}
