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
    private var creatureWriterMock: CreatureWriterMock!
    
    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatureWriterMock = CreatureWriterMock()
        bugCollectionViewCellViewModel = BugCollectionViewCellViewModel(
            bugData: bugs[0],
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatureWriterMock
        )
    }

    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatureWriterMock = nil
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
    
    func testIsBugAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let isBugAlreadySaved = bugCollectionViewCellViewModel.isBugAlreadySaved
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "Common Butterfly")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(isBugAlreadySaved, false)
    }
    
    func testToggleBugWhenIsNotAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let toggleSaved = bugCollectionViewCellViewModel.toggleSavedBug()
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureParameter, "Common Butterfly")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureCount, 1)
        XCTAssertEqual(toggleSaved, true)
    }
    
    func testToggleBugWhenIsAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = true
        let toggleSaved = bugCollectionViewCellViewModel.toggleSavedBug()
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureParameter, "Common Butterfly")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureCount, 1)
        XCTAssertEqual(toggleSaved, false)
    }
}
