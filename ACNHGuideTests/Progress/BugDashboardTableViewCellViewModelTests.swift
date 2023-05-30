//
//  BugDashboardTableViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 03/03/2023.
//

import XCTest
@testable import ACNHGuide

final class BugDashboardTableViewCellViewModelTests: XCTestCase {
    
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatueWriterMock: CreatureWriterMock!
    private var bugDashboardTableViewCellViewModel: BugDashboardTableViewCellViewModel!

    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatueWriterMock = CreatureWriterMock()
        bugDashboardTableViewCellViewModel = BugDashboardTableViewCellViewModel(
            bugsData: bugs,
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatueWriterMock
        )
    }

    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatueWriterMock = nil
        bugDashboardTableViewCellViewModel = nil
    }
    
    func testIconURL() throws {
        let iconURI = try XCTUnwrap(bugs.first?.iconURI, "Tests failed: testIconURL() from BugDashboardTableViewCellViewModelTests")
        let url = URL(string: iconURI)
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/bugs/1")
        XCTAssertEqual(bugDashboardTableViewCellViewModel.iconURL, url)
    }
    
    func testTitleText() {
        XCTAssertEqual(bugDashboardTableViewCellViewModel.titleText, "Bugs")
    }
    
    func testTotalText() {
        creaturePeekerMock.stubbedCreaturesSaved = [Bug(), Bug()]
        let bugsCount = bugs.count
        let titleText = bugDashboardTableViewCellViewModel.totalText
        XCTAssertEqual(bugsCount, 80)
        XCTAssertEqual(creaturePeekerMock.stubbedCreaturesSaved.count, 2)
        XCTAssertEqual(creaturePeekerMock.invokedCreatureSavedCount, 1)
        XCTAssertEqual(titleText, "\(2)/\(80)")
    }
    
    func testProgressOfBar() {
        creaturePeekerMock.stubbedCreaturesSaved = [Bug(), Bug()]
        let bugsCount = bugs.count
        let progressOfBar = bugDashboardTableViewCellViewModel.progressOfBar
        XCTAssertEqual(bugsCount, 80)
        XCTAssertEqual(creaturePeekerMock.stubbedCreaturesSaved.count, 2)
        XCTAssertEqual(creaturePeekerMock.invokedCreatureSavedCount, 1)
        XCTAssertEqual(progressOfBar, Float(2) / Float(80))
    }
}
