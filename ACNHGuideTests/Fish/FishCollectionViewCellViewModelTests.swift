//
//  FishCollectionViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import XCTest
@testable import ACNHGuide

final class FishCollectionViewCellViewModelTests: XCTestCase {
    
    private var fishCollectionViewCellViewModel: FishCollectionViewCellViewModel!
    
    override func setUpWithError() throws {
        fishCollectionViewCellViewModel = FishCollectionViewCellViewModel(fishData: fishes[0])
    }
    
    override func tearDownWithError() throws {
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
}
