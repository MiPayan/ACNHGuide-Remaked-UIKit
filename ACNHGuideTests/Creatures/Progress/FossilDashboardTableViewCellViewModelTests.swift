//
//  FossilDashboardTableViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 06/07/2023.
//

import XCTest
@testable import ACNHGuide

final class FossilDashboardTableViewCellViewModelTests: XCTestCase {
    
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatureWriterMock: CreatureWriterMock!
    private var fossilDashboardTableViewCellViewModel: FossilDashboardTableViewCellViewModel!

    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatureWriterMock = CreatureWriterMock()
        fossilDashboardTableViewCellViewModel = FossilDashboardTableViewCellViewModel(
            fossilsData: fossils,
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatureWriterMock
        )
    }

    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatureWriterMock = nil
        fossilDashboardTableViewCellViewModel = nil
    }
    
    func testImageURL() throws {
        let imageURL = try XCTUnwrap(fossils.first?.imageURI, "Tests failed: testImageURL() from FossilDashboardTableViewCellViewModelTests")
        let url = URL(string: imageURL)
        XCTAssertEqual(imageURL, "https://acnhapi.com/v1/images/fossils/acanthostega")
        XCTAssertEqual(fossilDashboardTableViewCellViewModel.imageURL, url)
    }
}
