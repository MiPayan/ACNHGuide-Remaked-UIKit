//
//  FishProgressDashboardViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 07/03/2023.
//

import XCTest
@testable import ACNHGuide

final class FishProgressDashboardViewModelTests: XCTestCase {
    
    private var serviceMock: ServiceMock!
    private var dispatchQueueMock: DispatchQueueMock!
    private var fishProgressDashboardViewModel: FishProgressDashboardViewModel!

    override func setUpWithError() throws {
        serviceMock = ServiceMock()
        dispatchQueueMock = DispatchQueueMock()
        fishProgressDashboardViewModel = FishProgressDashboardViewModel(service: serviceMock, mainDispatchQueue: dispatchQueueMock)
    }

    override func tearDownWithError() throws {
        serviceMock = nil
        dispatchQueueMock = nil
        fishProgressDashboardViewModel = nil
    }
    
    func testFailureGetFishes() {
        let expectation = expectation(description: "Failure to get fishes.")
        serviceMock.stubbedFishResult = (
            .failure(.urlInvalid)
        )
        
        fishProgressDashboardViewModel.failureHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetFishesCount)
            expectation.fulfill()
        }
        fishProgressDashboardViewModel.getFishesData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSuccessGetFishes() {
        let expectation = expectation(description: "Success to get fishes.")
        serviceMock.stubbedFishResult = (
            .success(fishes)
        )
        
        fishProgressDashboardViewModel.successHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetFishesCount)
            expectation.fulfill()
        }
        fishProgressDashboardViewModel.getFishesData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1, handler: nil)
    }
}
