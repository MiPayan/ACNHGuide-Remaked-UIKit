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
    
    override func setUpWithError() throws {
        seaCreatureCollectionViewCellViewModel = SeaCreatureCollectionViewCellViewModel(seaCreatureData: seaCreatures[0])
    }
    
    override func tearDownWithError() throws {
        seaCreatureCollectionViewCellViewModel = nil
    }
    
    func testFileName() {
        guard let fileName = seaCreatures.first?.fileName else {
            fatalError("Tests failed: testFileName() from FishCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(fileName, "seaweed")
        XCTAssertEqual(seaCreatureCollectionViewCellViewModel.filename, "Seaweed")
    }
    
    func testIconURL() {
        guard let iconURI = seaCreatures.first?.iconURI,
              let url = URL(string: iconURI) else {
            fatalError("Tests failed: testIconURL() from FishCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/sea/1")
        XCTAssertEqual(seaCreatureCollectionViewCellViewModel.iconURL, url)
    }
}
