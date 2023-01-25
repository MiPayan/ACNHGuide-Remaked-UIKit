//
//  BugViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

import XCTest
@testable import ACNHGuide

final class BugViewModelTests: XCTestCase {

    private var serviceMock: ServiceMock!
    private var currentCalendarMock: CurrentCalendarMock!
    private var bugsViewModel: BugViewModel!
    
    override func setUpWithError() throws {
        serviceMock = ServiceMock()
        currentCalendarMock = CurrentCalendarMock()
        bugsViewModel = BugViewModel(
            service: serviceMock,
            mainDispatchQueue: DispatchQueueMock(),
            currentCalendar: currentCalendarMock
        )
    }
    
    override func tearDownWithError() throws {
        serviceMock = nil
        currentCalendarMock = nil
        bugsViewModel = nil
    }
    
    func testFailureGetBugs() {
        let expectation = expectation(description: "Failure to get bugs.")
        serviceMock.stubbedBugResult = (
            .failure(.urlInvalid)
        )
        
        bugsViewModel.getBugData()
        XCTAssertEqual(1, serviceMock.invokedGetBugsCount)
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSuccessGetBugs() {
        let expectation = expectation(description: "Success to get bugs.")
        serviceMock.stubbedBugResult = (
            .success(bugs)
        )
        
        bugsViewModel.getBugData()
        XCTAssertEqual(1, serviceMock.invokedGetBugsCount)
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testMakeBugsFromTheNorthernHemisphere() {
        let expectation = expectation(description: "Sort bug from the northern hemisphere.")
        currentCalendarMock.stubbedMakeCurrentCalendar = {
            (11, 12)
        }()
        
        serviceMock.stubbedBugResult = (
            .success(bugs)
        )
        
        bugsViewModel.getBugData()
        let currentBugs = bugsViewModel.makeBugsFromTheNorthernHemisphere()
        
        XCTAssertEqual(1, currentCalendarMock.invockedMakeCurrentCalendarCount)
        XCTAssertEqual(1, serviceMock.invokedGetBugsCount)
        XCTAssertEqual(currentBugs.count, 14)
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testMakeBugsFromTheSouthernHemisphere() {
        let expectation = expectation(description: "Sort bug from the southern hemisphere.")
        currentCalendarMock.stubbedMakeCurrentCalendar = {
            (11, 12)
        }()
        
        serviceMock.stubbedBugResult = (
            .success(bugs)
        )
        
        bugsViewModel.getBugData()
        let currentBugs = bugsViewModel.makeBugsFromTheSouthernHemisphere()
        
        XCTAssertEqual(1, currentCalendarMock.invockedMakeCurrentCalendarCount)
        XCTAssertEqual(1, serviceMock.invokedGetBugsCount)
        XCTAssertEqual(currentBugs.count, 35)
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
    }
}
