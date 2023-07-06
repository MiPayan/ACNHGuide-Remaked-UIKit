//
//  FossilDetailsViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 03/03/2023.
//

import XCTest
@testable import ACNHGuide

final class FossilDetailsViewModelTests: XCTestCase {
    
    private var fossilDetailsViewModel: FossilDetailsViewModel!

    override func setUpWithError() throws {
        fossilDetailsViewModel = FossilDetailsViewModel(fossilData: fossils[0])
    }

    override func tearDownWithError() throws {
        fossilDetailsViewModel = nil
    }
    
    func testInit() {
        let fish = fossilDetailsViewModel.fossilData.fileName
        XCTAssertEqual(fish, "acanthostega")
    }
}
