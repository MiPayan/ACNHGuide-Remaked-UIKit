//
//  BugProgressDashboardViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 07/03/2023.
//

import XCTest
@testable import ACNHGuide

final class BugProgressDashboardViewModelTests: XCTestCase {

    private var serviceMock: ServiceMock!
    private var dispatchQueueMock: DispatchQueueMock!
    private var bugProgressDashboardViewModel: BugProgressDashboardViewModel!

    override func setUpWithError() throws {
        serviceMock = ServiceMock()
        dispatchQueueMock = DispatchQueueMock()
        bugProgressDashboardViewModel = BugProgressDashboardViewModel(service: serviceMock, mainDispatchQueue: dispatchQueueMock)
    }

    override func tearDownWithError() throws {
        serviceMock = nil
        dispatchQueueMock = nil
        bugProgressDashboardViewModel = nil
    }
    
    func testFailureGetBugs() {
        let expectation = expectation(description: "Failure to get fishes.")
        serviceMock.stubbedBugResult = (
            .failure(.urlInvalid)
        )
        
        bugProgressDashboardViewModel.failureHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetBugsCount)
            expectation.fulfill()
        }
        bugProgressDashboardViewModel.getBugsData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSuccessGetBugs() {
        let expectation = expectation(description: "Success to get fishes.")
        serviceMock.stubbedBugResult = (
            .success(bugs)
        )
        
        bugProgressDashboardViewModel.successHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetBugsCount)
            expectation.fulfill()
        }
        bugProgressDashboardViewModel.getBugsData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1, handler: nil)
    }
}
