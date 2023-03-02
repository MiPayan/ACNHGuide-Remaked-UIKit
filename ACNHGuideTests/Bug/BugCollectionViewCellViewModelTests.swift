//
//  BugCollectionViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import XCTest
@testable import ACNHGuide

final class BugCollectionViewCellViewModelTests: XCTestCase {
    
    private var bugCollectionViewCellViewModel: BugCollectionViewCellViewModel!
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatueWriterMock: CreatureWriterMock!
    
    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatueWriterMock = CreatureWriterMock()
        bugCollectionViewCellViewModel = BugCollectionViewCellViewModel(
            bugData: bugs[0],
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatueWriterMock
        )
    }

    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatueWriterMock = nil
        bugCollectionViewCellViewModel = nil
    }
    
    func testFileName() {
        guard let fileName = bugs.first?.fileName else {
            fatalError("Tests failed: testFileName() from BugCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(fileName, "common_butterfly")
        XCTAssertEqual(bugCollectionViewCellViewModel.fileName, "Common Butterfly")
    }
    
    func testIconURL() {
        guard let iconURI = bugs.first?.iconURI,
              let url = URL(string: iconURI) else {
            fatalError("Tests failed: testIconURL() from BugCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/bugs/1")
        XCTAssertEqual(bugCollectionViewCellViewModel.iconURL, url)
    }
    
    func testToggleSeaCreature() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let isSaved = bugCollectionViewCellViewModel.toggleSavedBug()
        XCTAssertEqual(1, creaturePeekerMock.invokedIsCreatureAlreadySaved)
        XCTAssertEqual(1, creatueWriterMock.invokedSaveCreatureCount)
        XCTAssertEqual(true, isSaved)
    }
}
