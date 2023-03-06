//
//  SeaCreaturesDetailsViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 03/03/2023.
//

import XCTest
@testable import ACNHGuide

final class SeaCreaturesDetailsViewModelTests: XCTestCase {
    
    private var seaCreaturesDetailsViewModel: SeaCreaturesDetailsViewModel!

    override func setUpWithError() throws {
        seaCreaturesDetailsViewModel = SeaCreaturesDetailsViewModel(seaCreatureData: seaCreatures[0])
    }

    override func tearDownWithError() throws {
        seaCreaturesDetailsViewModel = nil
    }
    
    func testInit() {
        let fish = seaCreaturesDetailsViewModel.seaCreatureData.fileName
        XCTAssertEqual(fish, "seaweed")
    }
}
