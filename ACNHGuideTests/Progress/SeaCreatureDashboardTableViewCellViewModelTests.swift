//
//  SeaCreatureDashboardTableViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 03/03/2023.
//

import XCTest
@testable import ACNHGuide

final class SeaCreatureDashboardTableViewCellViewModelTests: XCTestCase {
    
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatueWriterMock: CreatureWriterMock!
    private var seaCreatureDashboardTableViewCellViewModel: SeaCreatureDashboardTableViewCellViewModel!

    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatueWriterMock = CreatureWriterMock()
        seaCreatureDashboardTableViewCellViewModel = SeaCreatureDashboardTableViewCellViewModel(
            seaCreaturesData: seaCreatures,
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatueWriterMock
        )
    }

    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatueWriterMock = nil
        seaCreatureDashboardTableViewCellViewModel = nil
    }
    
    func testIconURL() throws {
        let iconURI = try XCTUnwrap(seaCreatures.first?.iconURI, "Tests failed: testIconURL() from SeaCreatureDashboardTableViewCellViewModelTests")
        let url = URL(string: iconURI)
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/sea/1")
        XCTAssertEqual(seaCreatureDashboardTableViewCellViewModel.iconURL, url)
    }
    
    func testTitleText() {
        XCTAssertEqual(seaCreatureDashboardTableViewCellViewModel.titleText, "Sea creatures")
    }
    
    func testTotalText() {
        creaturePeekerMock.stubbedCreaturesSaved = [Fish(), Fish()]
        let seaCreaturesCount = seaCreatures.count
        let totalText = seaCreatureDashboardTableViewCellViewModel.totalText
        XCTAssertEqual(seaCreaturesCount, 40)
        XCTAssertEqual(creaturePeekerMock.stubbedCreaturesSaved.count, 2)
        XCTAssertEqual(creaturePeekerMock.invokedCreatureSavedCount, 1)
        XCTAssertEqual(totalText, "\(2)/\(40)")
    }
    
    func testProgressOfBar() {
        creaturePeekerMock.stubbedCreaturesSaved = [Fish(), Fish()]
        let seaCreaturesCount = seaCreatures.count
        let progressOfBar = seaCreatureDashboardTableViewCellViewModel.progressOfBar
        XCTAssertEqual(seaCreaturesCount, 40)
        XCTAssertEqual(creaturePeekerMock.stubbedCreaturesSaved.count, 2)
        XCTAssertEqual(creaturePeekerMock.invokedCreatureSavedCount, 1)
        XCTAssertEqual(progressOfBar, Float(2) / Float(40))
    }
}
