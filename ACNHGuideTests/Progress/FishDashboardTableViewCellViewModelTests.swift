//
//  FishDashboardTableViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 03/03/2023.
//

import XCTest
@testable import ACNHGuide

final class FishDashboardTableViewCellViewModelTests: XCTestCase {
    
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatueWriterMock: CreatureWriterMock!
    private var fishDashboardTableViewCellViewModel: FishDashboardTableViewCellViewModel!

    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatueWriterMock = CreatureWriterMock()
        fishDashboardTableViewCellViewModel = FishDashboardTableViewCellViewModel(
            fishesData: fishes,
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatueWriterMock
        )
    }

    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatueWriterMock = nil
        fishDashboardTableViewCellViewModel = nil
    }
    
    func testIconURL() {
        guard let iconURI = fishes.first?.iconURI,
              let url = URL(string: iconURI) else {
            fatalError("Tests failed: testIconURL() from FishDashboardTableViewCellViewModelTests")
        }
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/fish/1")
        XCTAssertEqual(fishDashboardTableViewCellViewModel.iconURL, url)
    }
    
    func testTitleText() {
        XCTAssertEqual(fishDashboardTableViewCellViewModel.titleText, "Fishes")
    }
    
    func testTotalText() {
        creaturePeekerMock.stubbedCreaturesSaved = [Fish(), Fish()]
        let fishesCount = fishes.count
        let totalText = fishDashboardTableViewCellViewModel.totalText
        XCTAssertEqual(fishesCount, 80)
        XCTAssertEqual(creaturePeekerMock.stubbedCreaturesSaved.count, 2)
        XCTAssertEqual(creaturePeekerMock.invokedCreatureSavedCount, 1)
        XCTAssertEqual(totalText, "\(2)/\(80)")
    }
    
    func testProgressOfBar() {
        creaturePeekerMock.stubbedCreaturesSaved = [Fish(), Fish()]
        let fishesCount = fishes.count
        let progressOfBar = fishDashboardTableViewCellViewModel.progressOfBar
        XCTAssertEqual(fishesCount, 80)
        XCTAssertEqual(creaturePeekerMock.stubbedCreaturesSaved.count, 2)
        XCTAssertEqual(creaturePeekerMock.invokedCreatureSavedCount, 1)
        XCTAssertEqual(progressOfBar, Float(2) / Float(80))
    }
}
