//
//  FishServiceTest.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 07/03/2023.
//

import XCTest
@testable import ACNHGuide

final class FishServiceTest: XCTestCase {
    
    private var realmManagerMock: RealmManagerMock!
    private var fishService: FishService!

    override func setUpWithError() throws {
        realmManagerMock = RealmManagerMock()
        fishService = FishService(creatureManager: realmManagerMock)
    }

    override func tearDownWithError() throws {
        realmManagerMock = nil
        fishService = nil
    }
    
    func testSaveObject() {

    }
}
