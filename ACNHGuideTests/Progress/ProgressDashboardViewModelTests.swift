//
//  ProgressDashboardViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 15/03/2023.
//

import XCTest
@testable import ACNHGuide

final class ProgressDashboardViewModelTests: XCTestCase {
    
    private var serviceMock: ServiceMock!
    private var progressDashboardViewModel: ProgressDashboardViewModel!
    
    override func setUpWithError() throws {
        serviceMock = ServiceMock()
        progressDashboardViewModel = ProgressDashboardViewModel(service: serviceMock)
    }
    
    override func tearDownWithError() throws {
        serviceMock = nil
        progressDashboardViewModel = nil
    }
    
    func testFailureGetDatas() {
        let expectation = expectation(description: "Failure to get datas.")
        serviceMock.stubbedFishResult = (
            .failure(.urlInvalid)
        )
        
        serviceMock.stubbedSeaCreatureResult = (
            .failure(.urlInvalid)
        )
        
        serviceMock.stubbedBugResult = (
            .failure(.urlInvalid)
        )
        
        serviceMock.stubbedFossilResult = (
            .failure(.urlInvalid)
        )
        
        progressDashboardViewModel.failureHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetFishesCount)
            XCTAssertEqual(1, self.serviceMock.invokedGetSeaCreaturesCount)
            XCTAssertEqual(1, self.serviceMock.invokedGetBugsCount)
            XCTAssertEqual(1, self.serviceMock.invokedGetFossilsCount)
            expectation.fulfill()
        }
        progressDashboardViewModel.getDatas()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSuccessGetDatas() {
        let expectation = expectation(description: "Failure to get datas.")
        serviceMock.stubbedFishResult = (
            .success(fishes)
        )
        
        serviceMock.stubbedSeaCreatureResult = (
            .success(seaCreatures)
        )
        
        serviceMock.stubbedBugResult = (
            .success(bugs)
        )
        
        serviceMock.stubbedFossilResult = (
            .success(fossils)
        )
        
        progressDashboardViewModel.successHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetFishesCount)
            XCTAssertEqual(1, self.serviceMock.invokedGetSeaCreaturesCount)
            XCTAssertEqual(1, self.serviceMock.invokedGetBugsCount)
            XCTAssertEqual(1, self.serviceMock.invokedGetFossilsCount)
            expectation.fulfill()
        }
        progressDashboardViewModel.getDatas()
        waitForExpectations(timeout: 1, handler: nil)
    }
}
