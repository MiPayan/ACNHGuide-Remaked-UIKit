//
//  BugDetailsViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 03/03/2023.
//

import XCTest
@testable import ACNHGuide

final class BugDetailsViewModelTests: XCTestCase {
    
    private var bugDetailsViewModel: BugDetailsViewModel!

    override func setUpWithError() throws {
        bugDetailsViewModel = BugDetailsViewModel(bugData: bugs[0])
    }

    override func tearDownWithError() throws {
        bugDetailsViewModel = nil
    }
    
    func testInit() {
        let fish = bugDetailsViewModel.bugData.fileName
        XCTAssertEqual(fish, "common_butterfly")
    }
}
