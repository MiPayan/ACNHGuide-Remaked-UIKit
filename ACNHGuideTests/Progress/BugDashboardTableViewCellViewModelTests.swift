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
    
    func testIconURL() {
        guard let iconURI = bugs.first?.iconURI,
              let url = URL(string: iconURI) else {
            fatalError("Tests failed: testIconURL() from BugDashboardTableViewCellViewModelTests")
        }
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/bugs/1")
        XCTAssertEqual(bugDashboardTableViewCellViewModel.iconURL, url)
    }
    
    func testTitleText() {
        XCTAssertEqual(bugDashboardTableViewCellViewModel.titleText, "Bugs")
    }
    
    func testTotalText() {
        creaturePeekerMock.stubbedCreaturesSaved = [Bug(), Bug()]
        let bugsCount = bugs.count
        XCTAssertEqual(bugsCount, 80)
        XCTAssertEqual(creaturePeekerMock.stubbedCreaturesSaved.count, 2)
        XCTAssertEqual(bugDashboardTableViewCellViewModel.totalText, "\(2)/\(80)")
    }
    
    func testProgressOfBar() {
        creaturePeekerMock.stubbedCreaturesSaved = [Bug(), Bug()]
        let bugsCount = bugs.count
        XCTAssertEqual(bugsCount, 80)
        XCTAssertEqual(creaturePeekerMock.stubbedCreaturesSaved.count, 2)
        XCTAssertEqual(bugDashboardTableViewCellViewModel.progressOfBar, Float(2) / Float(80))
    }
}
