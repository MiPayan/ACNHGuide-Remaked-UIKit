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
    private var dispatchQueueMock: DispatchQueueMock!
    private var currentCalendarMock: CurrentCalendarMock!
    private var bugsViewModel: BugViewModel!
    
    override func setUpWithError() throws {
        serviceMock = ServiceMock()
        dispatchQueueMock = DispatchQueueMock()
        currentCalendarMock = CurrentCalendarMock()
        bugsViewModel = BugViewModel(
            service: serviceMock,
            mainDispatchQueue: dispatchQueueMock,
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
        bugsViewModel.getBugsData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
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
        bugsViewModel.getBugsData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSetHeaderSection() {
        let northernSectionHeader = bugsViewModel.setHeaderSection(with: 0)
        let southernSectionHeader = bugsViewModel.setHeaderSection(with: 1)
        XCTAssertEqual(northernSectionHeader, "Northern hemisphere")
        XCTAssertEqual(southernSectionHeader, "Southern hemisphere")
    }
    
    func testConfigureSectionCollectionView() {
        currentCalendarMock.stubbedMakeCurrentCalendar = {
            (11, 12)
        }()
        
        serviceMock.stubbedBugResult = {
            .success(bugs)
        }()
        bugsViewModel.getBugsData()
        
        let northernSection = bugsViewModel.configureSectionCollectionView(with: 0)
        let southernSection = bugsViewModel.configureSectionCollectionView(with: 1)
        
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        XCTAssertEqual(1, serviceMock.invokedGetBugsCount)
        XCTAssertEqual(2, currentCalendarMock.invockedMakeCurrentCalendarCount)
        XCTAssertEqual(northernSection, 14)
        XCTAssertEqual(southernSection, 35)
    }
    
    func testMakeBug() {
        currentCalendarMock.stubbedMakeCurrentCalendar = {
            (11, 12)
        }()
        
        serviceMock.stubbedBugResult = {
            .success(bugs)
        }()
        bugsViewModel.getBugsData()
        
        let section = 0
        let index = 0
        let bug = bugsViewModel.makeBug(with: section, index: index)
        XCTAssertEqual(bug.id, 1)
        XCTAssertEqual(1, serviceMock.invokedGetBugsCount)
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        XCTAssertEqual(1, currentCalendarMock.invockedMakeCurrentCalendarCount)
    }
}
