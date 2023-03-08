//
//  FossilDashboardTableViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 03/03/2023.
//

import XCTest
@testable import ACNHGuide

final class FossilDashboardTableViewCellViewModelTests: XCTestCase {
    
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatueWriterMock: CreatureWriterMock!
    private var fossilDashboardTableViewCellViewModel: FossilDashboardTableViewCellViewModel!

    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatueWriterMock = CreatureWriterMock()
        fossilDashboardTableViewCellViewModel = FossilDashboardTableViewCellViewModel(
            fossilsData: fossils,
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatueWriterMock
        )
    }

    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatueWriterMock = nil
        fossilDashboardTableViewCellViewModel = nil
    }
    
    func testImageURL() {
        guard let imageURI = fossils.first?.imageURI,
              let url = URL(string: imageURI) else {
            fatalError("Tests failed: testIconURL() from FossilDashboardTableViewCellViewModelTests")
        }
        XCTAssertEqual(imageURI, "https://acnhapi.com/v1/images/fossils/acanthostega")
        XCTAssertEqual(fossilDashboardTableViewCellViewModel.imageURL, url)
    }
    
    func testTitleText() {
        XCTAssertEqual(fossilDashboardTableViewCellViewModel.titleText, "Fossils")
    }
    
    func testTotalText() {
        creaturePeekerMock.stubbedCreaturesSaved = [Fossil(), Fossil()]
        let fossilsCount = fossils.count
        let totalText = fossilDashboardTableViewCellViewModel.totalText
        XCTAssertEqual(fossilsCount, 73)
        XCTAssertEqual(creaturePeekerMock.stubbedCreaturesSaved.count, 2)
        XCTAssertEqual(creaturePeekerMock.invokedCreatureSavedCount, 1)
        XCTAssertEqual(totalText, "\(2)/\(73)")
    }
    
    func testProgressOfBar() {
        creaturePeekerMock.stubbedCreaturesSaved = [Fossil(), Fossil()]
        let fossilsCount = fossils.count
        let progressOfBar = fossilDashboardTableViewCellViewModel.progressOfBar
        XCTAssertEqual(fossilsCount, 73)
        XCTAssertEqual(creaturePeekerMock.stubbedCreaturesSaved.count, 2)
        XCTAssertEqual(creaturePeekerMock.invokedCreatureSavedCount, 1)
        XCTAssertEqual(progressOfBar, Float(2) / Float(73))
    }
}
