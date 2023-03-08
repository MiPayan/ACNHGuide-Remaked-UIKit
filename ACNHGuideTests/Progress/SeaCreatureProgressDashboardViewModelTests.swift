//
//  SeaCreatureProgressDashboardViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 07/03/2023.
//

import XCTest
@testable import ACNHGuide

final class SeaCreatureProgressDashboardViewModelTests: XCTestCase {
    
    private var serviceMock: ServiceMock!
    private var dispatchQueueMock: DispatchQueueMock!
    private var seaCreatureProgressDashboardViewModel: SeaCreatureProgressDashboardViewModel!

    override func setUpWithError() throws {
        serviceMock = ServiceMock()
        dispatchQueueMock = DispatchQueueMock()
        seaCreatureProgressDashboardViewModel = SeaCreatureProgressDashboardViewModel(service: serviceMock, mainDispatchQueue: dispatchQueueMock)
    }

    override func tearDownWithError() throws {
        serviceMock = nil
        dispatchQueueMock = nil
        seaCreatureProgressDashboardViewModel = nil
    }
    
    func testFailureGetSeaCreatures() {
        let expectation = expectation(description: "Failure to get fishes.")
        serviceMock.stubbedSeaCreatureResult = (
            .failure(.urlInvalid)
        )
        
        seaCreatureProgressDashboardViewModel.failureHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetSeaCreaturesCount)
            expectation.fulfill()
        }
        seaCreatureProgressDashboardViewModel.getSeaCreaturesData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSuccessGetSeaCreatures() {
        let expectation = expectation(description: "Success to get fishes.")
        serviceMock.stubbedSeaCreatureResult = (
            .success(seaCreatures)
        )
        
        seaCreatureProgressDashboardViewModel.successHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetSeaCreaturesCount)
            expectation.fulfill()
        }
        seaCreatureProgressDashboardViewModel.getSeaCreaturesData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1, handler: nil)
    }
}
