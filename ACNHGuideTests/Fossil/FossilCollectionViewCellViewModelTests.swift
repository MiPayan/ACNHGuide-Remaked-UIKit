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

    override func setUpWithError() throws {
        fossilCollectionViewCellViewModel = FossilCollectionViewCellViewModel(fossilData: fossils[0])
    }

    override func tearDownWithError() throws {
        fossilCollectionViewCellViewModel = nil
    }
    
    func testFileName() {
        guard let filename = fossils.first?.fileName else {
            fatalError("Tests failed: testFileName() from FossilCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(filename, "acanthostega")
        XCTAssertEqual(fossilCollectionViewCellViewModel.filename, "Acanthostega")
    }
    
    func testImageURL() {
        guard let imageURI = fossils.first?.imageURI,
              let url = URL(string: imageURI) else {
            fatalError("Tests failed: testImageURL() from FossilCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(imageURI, "https://acnhapi.com/v1/images/fossils/acanthostega")
        XCTAssertEqual(fossilCollectionViewCellViewModel.imageURL, url)
    }
}
