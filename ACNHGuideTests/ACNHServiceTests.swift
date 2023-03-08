//
//  ACNHServiceTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 07/03/2023.
//

import XCTest
@testable import ACNHGuide

final class ACNHServiceTests: XCTestCase {
    
    private var networkingMock: NetworkingMock<Any>!
    private var service: ACNHService!
    
    override func setUpWithError() throws {
        networkingMock = NetworkingMock()
        service = ACNHService(session: networkingMock)
    }
    
    override func tearDownWithError() throws {
        networkingMock = nil
        service = nil
    }
    
    func testGetFishesData() {
//        let expectation = expectation(description: "Success to get fishes data.")
//        networkingMock.stubbedResult = .success(fishes)
//        service.getFishesData { result in
//            expectation.fulfill()
//        }
//        XCTAssertEqual(networkingMock.invokedFetchDataCount, 1)
//        XCTAssertEqual(networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/fish/")
//        waitForExpectations(timeout: 1, handler: nil)
    }
}
