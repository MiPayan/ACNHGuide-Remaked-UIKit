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
        cancellables.removeAll()
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
        
        fishViewModel.loadCreature()
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
        
        fishViewModel.loadCreature()
        waitForExpectations(timeout: 1)
    }
    
    func testHeaderForNorthernHemisphere() {
        fishViewModel.isShowingNorthCreature = true
        XCTAssertTrue(fishViewModel.isShowingNorthCreature)
        XCTAssertEqual(fishViewModel.header, "Northern hemisphere")
    }
    
    func testHeaderForSouthernHemisphere() {
        fishViewModel.isShowingNorthCreature = false
        XCTAssertFalse(fishViewModel.isShowingNorthCreature)
        XCTAssertEqual(fishViewModel.header, "Southern hemisphere")
    }
    
    func testNumberOfItemsInSectionFromNorthernHemisphere() {
        
    }
    
    func testMakeFishFromNorthernHemisphere() {
        currentCalendarMock.stubbedMakeCurrentCalendar = (1, 7)
        fishViewModel.creatures = fishes
        fishViewModel.isShowingNorthCreature = true
        
        let index = 0
        let fish = fishViewModel.makeFish(with: index)
        
        XCTAssertTrue(fishViewModel.isShowingNorthCreature)
        XCTAssertEqual(3, fish.id)
        XCTAssertEqual(1, currentCalendarMock.invockedMakeCurrentCalendarCount)
    }
    
    func testMakeFishFromSouthernHemisphere() {
        currentCalendarMock.stubbedMakeCurrentCalendar = (1, 7)
        fishViewModel.creatures = fishes
        fishViewModel.isShowingNorthCreature = false
        
        let index = 0
        let fish = fishViewModel.makeFish(with: index)
        
        XCTAssertFalse(fishViewModel.isShowingNorthCreature)
        XCTAssertEqual(1, fish.id)
        XCTAssertEqual(1, currentCalendarMock.invockedMakeCurrentCalendarCount)
    }
}
