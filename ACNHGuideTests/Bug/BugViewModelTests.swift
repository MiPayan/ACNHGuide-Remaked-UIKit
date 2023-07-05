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
                XCTAssertEqual(error as! NetworkingError, NetworkingError.urlInvalid)
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
}
