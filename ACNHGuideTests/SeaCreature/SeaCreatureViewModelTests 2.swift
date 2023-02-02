//
//  SeaCreatureViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

import XCTest
@testable import ACNHGuide

final class SeaCreatureViewModelTests: XCTestCase {
    
    private var serviceMock: ServiceMock!
    private var currentCalendarMock: CurrentCalendarMock!
    private var seaCreaturesViewModel: SeaCreatureViewModel!
    
    override func setUpWithError() throws {
        serviceMock = ServiceMock()
        currentCalendarMock = CurrentCalendarMock()
        seaCreaturesViewModel = SeaCreatureViewModel(service: serviceMock, mainDispatchQueue: DispatchQueueMock(), currentCalendar: currentCalendarMock)
    }
    
    override func tearDownWithError() throws {
        currentCalendarMock = nil
        seaCreaturesViewModel = nil
        serviceMock = nil
    }
    
    func testFailureGetSeaCreature() {
        let expectation = expectation(description: "Failure to get sea creatures.")
        serviceMock.stubbedSeaCreatureResult = (
            .failure(.urlInvalid)
        )
        
        seaCreaturesViewModel.getSeaCreatureData()
        XCTAssertEqual(1, serviceMock.invokedGetSeaCreaturesCount)
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSuccessGetSeaCreatures() {
        let expectation = expectation(description: "Success to get sea creatures.")
        serviceMock.stubbedSeaCreatureResult = (
            .success(seaCreatures)
        )
        
        seaCreaturesViewModel.getSeaCreatureData()
        XCTAssertEqual(1, serviceMock.invokedGetSeaCreaturesCount)
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testMakeSeaCreaturesFromTheNorthernHemisphere() {
        let expectation = expectation(description: "Sort sea creature from the northern hemisphere.")
        currentCalendarMock.stubbedMakeCurrentCalendar = {
            (11, 12)
        }()
        
        serviceMock.stubbedSeaCreatureResult = (
            .success(seaCreatures)
        )
        
        seaCreaturesViewModel.getSeaCreatureData()
        let currentSeaCreatures = seaCreaturesViewModel.makeSeaCreaturesFromTheNorthernHemisphere()
        
        XCTAssertEqual(1, currentCalendarMock.invockedMakeCurrentCalendarCount)
        XCTAssertEqual(1, serviceMock.invokedGetSeaCreaturesCount)
        XCTAssertEqual(currentSeaCreatures.count, 18)
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testMakeSeaCreaturesFromTheSouthernHemisphere() {
        let expectation = expectation(description: "Sort sea creature from the southern hemisphere.")
        currentCalendarMock.stubbedMakeCurrentCalendar = {
            (11, 12)
        }()
        
        serviceMock.stubbedSeaCreatureResult = (
            .success(seaCreatures)
        )
        
        seaCreaturesViewModel.getSeaCreatureData()
        let currentSeaCreatures = seaCreaturesViewModel.makeSeaCreaturesFromTheSouthernHemisphere()
        
        XCTAssertEqual(1, currentCalendarMock.invockedMakeCurrentCalendarCount)
        XCTAssertEqual(1, serviceMock.invokedGetSeaCreaturesCount)
        XCTAssertEqual(currentSeaCreatures.count, 17)
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
    }
}
