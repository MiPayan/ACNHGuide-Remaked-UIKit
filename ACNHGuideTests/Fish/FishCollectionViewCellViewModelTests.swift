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
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatueWriterMock: CreatureWriterMock!
    
    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatueWriterMock = CreatureWriterMock()
        fishCollectionViewCellViewModel = FishCollectionViewCellViewModel(
            fishData: fishes[0],
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatueWriterMock
        )
    }
    
    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatueWriterMock = nil
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
    
    func testToggleSavedFish() {
        
    }
}
