//
//  FishDashboardTableViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 06/07/2023.
//

import XCTest
@testable import ACNHGuide

final class FishDashboardTableViewCellViewModelTests: XCTestCase {
    
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatureWriterMock: CreatureWriterMock!
    private var fishDashboardTableViewCellViewModel: FishDashboardTableViewCellViewModel!

    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatureWriterMock = CreatureWriterMock()
        fishDashboardTableViewCellViewModel = FishDashboardTableViewCellViewModel(
            fishesData: fishes,
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatureWriterMock
        )
    }

    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatureWriterMock = nil
        fishDashboardTableViewCellViewModel = nil
    }
    
    func testIconURL() throws {
        let iconURI = try XCTUnwrap(fishes.first?.iconURI, "Tests failed: testIconURL() from FishDashboardTableViewCellViewModelTests")
        let url = URL(string: iconURI)
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/fish/1")
        XCTAssertEqual(fishDashboardTableViewCellViewModel.iconURL, url)
    }
}
