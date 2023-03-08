//
//  FossilProgressDashboardViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 07/03/2023.
//

import XCTest
@testable import ACNHGuide

final class FossilProgressDashboardViewModelTests: XCTestCase {

    private var serviceMock: ServiceMock!
    private var dispatchQueueMock: DispatchQueueMock!
    private var fossilProgressDashboardViewModel: FossilProgressDashboardViewModel!

    override func setUpWithError() throws {
        serviceMock = ServiceMock()
        dispatchQueueMock = DispatchQueueMock()
        fossilProgressDashboardViewModel = FossilProgressDashboardViewModel(service: serviceMock, mainDispatchQueue: dispatchQueueMock)
    }

    override func tearDownWithError() throws {
        serviceMock = nil
        dispatchQueueMock = nil
        fossilProgressDashboardViewModel = nil
    }
    
    func testFailureGetFossils() {
        let expectation = expectation(description: "Failure to get fishes.")
        serviceMock.stubbedFossilResult = (
            .failure(.urlInvalid)
        )
        
        fossilProgressDashboardViewModel.failureHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetFossilsCount)
            expectation.fulfill()
        }
        fossilProgressDashboardViewModel.getFossilsData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSuccessGetFossils() {
        let expectation = expectation(description: "Success to get fishes.")
        serviceMock.stubbedFossilResult = (
            .success(fossils)
        )
        
        fossilProgressDashboardViewModel.successHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetFossilsCount)
            expectation.fulfill()
        }
        fossilProgressDashboardViewModel.getFossilsData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1, handler: nil)
    }
}
