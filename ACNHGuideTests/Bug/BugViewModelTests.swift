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
        
        bugsViewModel.failureHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetBugsCount)
            expectation.fulfill()

        }
        bugsViewModel.getBugData()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSuccessGetBugs() {
        let expectation = expectation(description: "Success to get bugs.")
        serviceMock.stubbedBugResult = (
            .success(bugs)
        )
        
        bugsViewModel.successHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetBugsCount)
            expectation.fulfill()
        }
        bugsViewModel.getBugData()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSetHeaderSection() {
        let northernSectionHeader = bugsViewModel.setHeaderSection(with: 0)
        let southernSectionHeader = bugsViewModel.setHeaderSection(with: 1)
        XCTAssertEqual(northernSectionHeader, "Northern hemisphere")
        XCTAssertEqual(southernSectionHeader, "Southern hemisphere")
    }
    
    func testConfigureSectionCollectionView() {
        let expectation = expectation(description: "Sort fishes.")
        currentCalendarMock.stubbedMakeCurrentCalendar = {
            (11, 12)
        }()
        
        serviceMock.stubbedBugResult = {
            .success(bugs)
        }()
        
        bugsViewModel.successHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetBugsCount)
        }
        
        bugsViewModel.getBugData()
        
        let northernSection = bugsViewModel.configureSectionCollectionView(with: 0)
        let southernSection = bugsViewModel.configureSectionCollectionView(with: 1)
        
        XCTAssertEqual(2, currentCalendarMock.invockedMakeCurrentCalendarCount)
        XCTAssertEqual(northernSection, 14)
        XCTAssertEqual(southernSection, 35)
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
    }
}
