//
//  FishViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

import XCTest
import Combine
@testable import ACNHGuide

final class FishViewModelTests: XCTestCase {
    
    private var loaderMock: CreatureLoaderMock!
    private var currentCalendarMock: CurrentCalendarMock!
    private var fishViewModel: FishViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        loaderMock = CreatureLoaderMock()
        currentCalendarMock = CurrentCalendarMock()
        fishViewModel = FishViewModel(
            loader: loaderMock,
            currentCalendar: currentCalendarMock
        )
    }
    
    override func tearDownWithError() throws {
        currentCalendarMock = nil
        fishViewModel = nil
        loaderMock = nil
    }
    
    func testFailureLoadFishes() {
        let expectation = expectation(description: "Failure to load fishes data.")
        loaderMock.stubbedFishesPublisher = Fail(error: .urlInvalid)
            .eraseToAnyPublisher()
        
        fishViewModel.failureHandler
            .sink { error in
                XCTAssertEqual(error as! NetworkingError, NetworkingError.urlInvalid)
                XCTAssertEqual(1, self.loaderMock.invokedLoadFishesData)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        fishViewModel.loadCreatures()
        waitForExpectations(timeout: 1)
    }
    
    func testSuccessLoadFishes() {
        let expectation = expectation(description: "Success to load fishes data.")
        loaderMock.stubbedFishesPublisher = Result.success(fishes)
            .publisher
            .eraseToAnyPublisher()
        
        fishViewModel.reloadData
            .sink { _ in
                XCTAssertEqual(self.fishViewModel.creatures, fishes)
                XCTAssertEqual(1, self.loaderMock.invokedLoadFishesData)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        fishViewModel.loadCreatures()
        waitForExpectations(timeout: 1)
    }
}
