//
//  BugViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 05/07/2023.
//

import XCTest
import Combine
@testable import ACNHGuide

final class BugViewModelTests: XCTestCase {

    private var loaderMock: CreatureLoaderMock!
    private var currentCalendarMock: CurrentCalendarMock!
    private var bugViewModel: BugViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        cancellables.removeAll()
        loaderMock = CreatureLoaderMock()
        currentCalendarMock = CurrentCalendarMock()
        bugViewModel = BugViewModel(
            loader: loaderMock,
            currentCalendar: currentCalendarMock
        )
    }
    
    override func tearDownWithError() throws {
        currentCalendarMock = nil
        bugViewModel = nil
        loaderMock = nil
    }
    
    func testFailureLoadBugs() {
        let expectation = expectation(description: "Failure to load bugs data.")
        loaderMock.stubbedBugsPublisher = Fail(error: .urlInvalid)
            .eraseToAnyPublisher()
        
        bugViewModel.failureHandler
            .sink { error in
                XCTAssertEqual(error as! NetworkerError, NetworkerError.urlInvalid)
                XCTAssertEqual(1, self.loaderMock.invokedBugsData)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        bugViewModel.loadCreature()
        waitForExpectations(timeout: 1)
    }
    
    func testSuccessLoadBugs() {
        let expectation = expectation(description: "Success to load bugs data.")
        loaderMock.stubbedBugsPublisher = Result.success(bugs)
            .publisher
            .eraseToAnyPublisher()
        
        bugViewModel.reloadData
            .sink { _ in
                XCTAssertEqual(self.bugViewModel.creatures, bugs)
                XCTAssertEqual(1, self.loaderMock.invokedBugsData)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        bugViewModel.loadCreature()
        waitForExpectations(timeout: 1)
    }
    
    func testHeaderForNorthernHemisphere() {
        bugViewModel.isShowingNorthCreature = true
        XCTAssertTrue(bugViewModel.isShowingNorthCreature)
        XCTAssertEqual(bugViewModel.header, "Northern hemisphere")
    }
    
    func testHeaderForSouthernHemisphere() {
        bugViewModel.isShowingNorthCreature = false
        XCTAssertFalse(bugViewModel.isShowingNorthCreature)
        XCTAssertEqual(bugViewModel.header, "Southern hemisphere")
    }
    
    
    func testMakeBugFromNorthernHemisphere() {
        currentCalendarMock.stubbedMakeCurrentCalendar = (1, 7)
        bugViewModel.creatures = bugs
        bugViewModel.isShowingNorthCreature = true
        
        let index = 0
        let bug = bugViewModel.makeBug(with: index)
        
        XCTAssertTrue(bugViewModel.isShowingNorthCreature)
        XCTAssertEqual(9, bug.id)
        XCTAssertEqual(1, currentCalendarMock.invockedMakeCurrentCalendarCount)
    }
    
    func testMakeBugFromSouthernHemisphere() {
        currentCalendarMock.stubbedMakeCurrentCalendar = (1, 7)
        bugViewModel.creatures = bugs
        bugViewModel.isShowingNorthCreature = false
        
        let index = 0
        let bug = bugViewModel.makeBug(with: index)
        
        XCTAssertFalse(bugViewModel.isShowingNorthCreature)
        XCTAssertEqual(9, bug.id)
        XCTAssertEqual(1, currentCalendarMock.invockedMakeCurrentCalendarCount)
    }
}
