//
//  BugDashboardTableViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 06/07/2023.
//

import XCTest
@testable import ACNHGuide

final class BugDashboardTableViewCellViewModelTests: XCTestCase {

    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatureWriterMock: CreatureWriterMock!
    private var bugDashboardTableViewCellViewModel: BugDashboardTableViewCellViewModel!

    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatureWriterMock = CreatureWriterMock()
        bugDashboardTableViewCellViewModel = BugDashboardTableViewCellViewModel(
            bugsData: bugs,
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatureWriterMock
        )
    }

    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatureWriterMock = nil
        bugDashboardTableViewCellViewModel = nil
    }
    
    func testIconURL() throws {
        let iconURI = try XCTUnwrap(bugs.first?.iconURI, "Tests failed: testIconURL() from BugDashboardTableViewCellViewModelTests")
        let url = URL(string: iconURI)
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/bugs/1")
        XCTAssertEqual(bugDashboardTableViewCellViewModel.iconURL, url)
    }
}
