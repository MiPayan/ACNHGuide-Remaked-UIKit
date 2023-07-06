//
//  SeaCreatureDashboardTableViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 06/07/2023.
//

import XCTest
@testable import ACNHGuide

final class SeaCreatureDashboardTableViewCellViewModelTests: XCTestCase {
    
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatureWriterMock: CreatureWriterMock!
    private var seaCreatureDashboardTableViewCellViewModel: SeaCreatureDashboardTableViewCellViewModel!

    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatureWriterMock = CreatureWriterMock()
        seaCreatureDashboardTableViewCellViewModel = SeaCreatureDashboardTableViewCellViewModel(
            seaCreaturesData: seaCreatures,
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatureWriterMock
        )
    }

    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatureWriterMock = nil
        seaCreatureDashboardTableViewCellViewModel = nil
    }
    
    func testIconURL() throws {
        let iconURI = try XCTUnwrap(seaCreatures.first?.iconURI, "Tests failed: testIconURL() from SeaCreatureDashboardTableViewCellViewModelTests")
        let url = URL(string: iconURI)
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/sea/1")
        XCTAssertEqual(seaCreatureDashboardTableViewCellViewModel.iconURL, url)
    }
}
