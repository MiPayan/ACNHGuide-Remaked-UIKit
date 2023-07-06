//
//  v.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 04/07/2023.
//

import Foundation

import XCTest
import Combine
@testable import ACNHGuide

final class SeaCreatureViewModelTests: XCTestCase {
    
    private var loaderMock: CreatureLoaderMock!
    private var currentCalendarMock: CurrentCalendarMock!
    private var seaCreatureViewModel: SeaCreatureViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        cancellables.removeAll()
        loaderMock = CreatureLoaderMock()
        currentCalendarMock = CurrentCalendarMock()
        seaCreatureViewModel = SeaCreatureViewModel(
            loader: loaderMock,
            currentCalendar: currentCalendarMock
        )
    }
    
    override func tearDownWithError() throws {
        currentCalendarMock = nil
        seaCreatureViewModel = nil
        loaderMock = nil
    }
    
    func testFailureLoadSeaCreatures() {
        let expectation = expectation(description: "Failure to load sea creatures data.")
        loaderMock.stubbedSeaCreaturesPublisher = Fail(error: .urlInvalid)
            .eraseToAnyPublisher()
        
        seaCreatureViewModel.failureHandler
            .sink { error in
                XCTAssertEqual(error as! NetworkerError, NetworkerError.urlInvalid)
                XCTAssertEqual(1, self.loaderMock.invokedLoadSeaCreaturesData)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        seaCreatureViewModel.loadCreature()
        waitForExpectations(timeout: 1)
    }
    
    func testSuccessLoadSeaCreatures() {
        let expectation = expectation(description: "Success to load sea creatures data.")
        loaderMock.stubbedSeaCreaturesPublisher = Result.success(seaCreatures)
            .publisher
            .eraseToAnyPublisher()
        
        seaCreatureViewModel.reloadData
            .sink { _ in
                XCTAssertEqual(self.seaCreatureViewModel.creatures, seaCreatures)
                XCTAssertEqual(1, self.loaderMock.invokedLoadSeaCreaturesData)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        seaCreatureViewModel.loadCreature()
        waitForExpectations(timeout: 1)
    }
    
    func testHeaderForNorthernHemisphere() {
        seaCreatureViewModel.isShowingNorthCreature = true
        XCTAssertTrue(seaCreatureViewModel.isShowingNorthCreature)
        XCTAssertEqual(seaCreatureViewModel.header, "Northern hemisphere")
    }
    
    func testHeaderForSouthernHemisphere() {
        seaCreatureViewModel.isShowingNorthCreature = false
        XCTAssertFalse(seaCreatureViewModel.isShowingNorthCreature)
        XCTAssertEqual(seaCreatureViewModel.header, "Southern hemisphere")
    }
    
    func testMakeSeaCreatureFromNorthernHemisphere() {
        currentCalendarMock.stubbedMakeCurrentCalendar = (1, 7)
        seaCreatureViewModel.creatures = seaCreatures
        seaCreatureViewModel.isShowingNorthCreature = true
        
        let index = 0
        let seaCreature = seaCreatureViewModel.makeSeaCreature(with: index)
        
        XCTAssertTrue(seaCreatureViewModel.isShowingNorthCreature)
        XCTAssertEqual(1, seaCreature.id)
        XCTAssertEqual(1, currentCalendarMock.invockedMakeCurrentCalendarCount)
    }
    
    func testMakeSeaCreatureFromSouthernHemisphere() {
        currentCalendarMock.stubbedMakeCurrentCalendar = (1, 7)
        seaCreatureViewModel.creatures = seaCreatures
        seaCreatureViewModel.isShowingNorthCreature = false
        
        let index = 0
        let seaCreature = seaCreatureViewModel.makeSeaCreature(with: index)
        
        XCTAssertFalse(seaCreatureViewModel.isShowingNorthCreature)
        XCTAssertEqual(1, seaCreature.id)
        XCTAssertEqual(1, currentCalendarMock.invockedMakeCurrentCalendarCount)
    }
}
