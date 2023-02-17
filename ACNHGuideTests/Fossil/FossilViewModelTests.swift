//
//  FossilViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

import XCTest
@testable import ACNHGuide

final class FossilViewModelTests: XCTestCase {
    
    private var serviceMock: ServiceMock!
    private var fossilsViewModel: FossilViewModel!
    
    override func setUpWithError() throws {
        serviceMock = ServiceMock()
        fossilsViewModel = FossilViewModel(service: serviceMock)
    }
    
    override func tearDownWithError() throws {
        fossilsViewModel = nil
    }
    
    func testFailureGetFossils() {
        let expectation = expectation(description: "Failure to get fossils.")
        
        serviceMock.stubbedFossilResult = (
            .failure(.urlInvalid)
        )
        
        fossilsViewModel.failureHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetFossilsCount)
            expectation.fulfill()
        }
        fossilsViewModel.getFossilData()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSuccessGetFossils() {
        let expectation = expectation(description: "Success to get fossils.")
        
        serviceMock.stubbedFossilResult = (
            .success(fossils)
        )
        
        fossilsViewModel.successHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetFossilsCount)
            expectation.fulfill()
        }
        fossilsViewModel.getFossilData()
        waitForExpectations(timeout: 1, handler: nil)
    }
}
