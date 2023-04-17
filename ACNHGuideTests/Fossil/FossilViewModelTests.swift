//
//  FossilViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

import XCTest
@testable import ACNHGuide

final class FossilViewModelTests: XCTestCase {
    
    private var serviceMock: CreatureServicesMock!
    private var dispatchQueueMock: DispatchQueueMock!
    private var currentCalendarMock: CurrentCalendarMock!
    private var fossilsViewModel: FossilViewModel!
    
    override func setUpWithError() throws {
        serviceMock = CreatureServicesMock()
        dispatchQueueMock = DispatchQueueMock()
        currentCalendarMock = CurrentCalendarMock()
        fossilsViewModel = FossilViewModel(
            service: serviceMock,
            mainDispatchQueue: dispatchQueueMock,
            currentCalendar: currentCalendarMock
        )
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
        fossilsViewModel.getFossilsData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
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
        fossilsViewModel.getFossilsData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1, handler: nil)
    }
}
