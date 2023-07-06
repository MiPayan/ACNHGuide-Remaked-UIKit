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
                XCTAssertEqual(error as! NetworkingError, NetworkingError.urlInvalid)
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
}
