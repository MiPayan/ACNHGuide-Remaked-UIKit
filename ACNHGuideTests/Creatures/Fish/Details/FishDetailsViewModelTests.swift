//
//  FishDetailsViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 03/03/2023.
//

import XCTest
@testable import ACNHGuide

final class FishDetailsViewModelTests: XCTestCase {
    
    private var fishDetailsViewModel: FishDetailsViewModel!

    override func setUpWithError() throws {
        fishDetailsViewModel = FishDetailsViewModel(fishData: fishes[0])
    }

    override func tearDownWithError() throws {
        fishDetailsViewModel = nil
    }
    
    func testInit() {
        let fish = fishDetailsViewModel.fishData.fileName
        XCTAssertEqual(fish, "bitterling")
    }
}
