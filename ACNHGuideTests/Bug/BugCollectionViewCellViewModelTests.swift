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

    override func setUpWithError() throws {
        bugCollectionViewCellViewModel = BugCollectionViewCellViewModel(bugData: bugs[0])
    }

    override func tearDownWithError() throws {
        bugCollectionViewCellViewModel = nil
    }
    
    func testFileName() {
        guard let fileName = bugs.first?.fileName else {
            fatalError("Tests failed: testFileName() from BugCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(fileName, "common_butterfly")
        XCTAssertEqual(bugCollectionViewCellViewModel.filename, "Common Butterfly")
    }
    
    func testIconURL() {
        guard let iconURI = bugs.first?.iconURI,
              let url = URL(string: iconURI) else {
            fatalError("Tests failed: testIconURL() from BugCollectionViewCellViewModelTests")
        }
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/bugs/1")
        XCTAssertEqual(bugCollectionViewCellViewModel.iconURL, url)
    }
}
