//
//  FossilDetailsViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 01/02/2023.
//

import XCTest
@testable import ACNHGuide

final class FossilDetailsViewModelTests: XCTestCase {

    private var fossilDetailsViewModel: FossilDetailsViewModel!
    
    override func setUpWithError() throws {
        fossilDetailsViewModel = FossilDetailsViewModel(fossilData: fossils[0])
    }
    
    override func tearDownWithError() throws {
        fossilDetailsViewModel = nil
    }
    
    func testFileName() {
        guard let fileName = fossils.first?.fileName else { return }
        let formatFileName = fileName.replaceCharacter("_", by: "").capitalized
        XCTAssertEqual(fileName, "acanthostega")
        XCTAssertEqual(fossilDetailsViewModel.filename, formatFileName)
    }
    
    func testImageURI() {
        guard let imageURI = fossils.first?.imageURI,
            let url = URL(string: imageURI) else { return }
        XCTAssertEqual(imageURI, "https://acnhapi.com/v1/images/fossils/acanthostega")
        XCTAssertEqual(fossilDetailsViewModel.imageURL, url)
    }
    
    func testPrice() {
        guard let price = fossils.first?.price else { return }
        XCTAssertEqual(price, 2000)
        XCTAssertEqual(fossilDetailsViewModel.price, String(price))
    }
    
    func testMuseumPhrase() {
        guard let museumPhrase = fossils.first?.museumPhrase else { return }
        XCTAssertEqual(museumPhrase, "The acanthostega! Said to be one of the earliest amphibians, it existed well before dinosaurs. Because they lived as fish not long before, they still had gills and very webbed \"hands.\". To toss away the life they knew and venture onto unknown lands... they must have been very brave! Hmm... Does it still count as bravery if you have no understanding of what you're doing?")
        XCTAssertEqual(fossilDetailsViewModel.museumPhrase, museumPhrase)
    }
}
