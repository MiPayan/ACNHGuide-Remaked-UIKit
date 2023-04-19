//
//  SeaCreatureViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

import XCTest
@testable import ACNHGuide

final class SeaCreatureViewModelTests: XCTestCase {
    
    private var serviceMock: CreatureServicesMock!
    private var dispatchQueueMock: DispatchQueueMock!
    private var currentCalendarMock: CurrentCalendarMock!
    private var seaCreaturesViewModel: SeaCreatureViewModel!

    override func setUpWithError() throws {
        serviceMock = CreatureServicesMock()
        dispatchQueueMock = DispatchQueueMock()
        currentCalendarMock = CurrentCalendarMock()
        seaCreaturesViewModel = SeaCreatureViewModel(
            service: serviceMock,
            mainDispatchQueue: dispatchQueueMock,
            currentCalendar: currentCalendarMock
        )
    }
    
    override func tearDownWithError() throws {
        currentCalendarMock = nil
        dispatchQueueMock = nil
        seaCreaturesViewModel = nil
        serviceMock = nil
    }
    
    func testFailureGetSeaCreatures() {
        let expectation = expectation(description: "Failure to get sea creatures.")
        serviceMock.stubbedSeaCreatureResult = (
            .failure(.urlInvalid)
        )
        
        seaCreaturesViewModel.failureHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetSeaCreaturesCount)
            expectation.fulfill()
        }
        seaCreaturesViewModel.getSeaCreaturesData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1)
    }
    
    func testSuccessGetSeaCreatures() {
        let expectation = expectation(description: "Success to get sea creatures.")
        serviceMock.stubbedSeaCreatureResult = (
            .success(seaCreatures)
        )
        
        seaCreaturesViewModel.successHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetSeaCreaturesCount)
            expectation.fulfill()
        }
        seaCreaturesViewModel.getSeaCreaturesData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1)
    }
    
    
    func testSetHeaderSection() {
        let northernSectionHeader = seaCreaturesViewModel.setHeaderSection(with: 0)
        let southernSectionHeader = seaCreaturesViewModel.setHeaderSection(with: 1)
        XCTAssertEqual(northernSectionHeader, "Northern hemisphere")
        XCTAssertEqual(southernSectionHeader, "Southern hemisphere")
    }
    
    func testConfigureSectionCollectionView() {
        currentCalendarMock.stubbedMakeCurrentCalendar = {
            (11, 12)
        }()
        
        serviceMock.stubbedSeaCreatureResult = {
            .success(seaCreatures)
        }()
        seaCreaturesViewModel.getSeaCreaturesData()
        
        let northernSection = seaCreaturesViewModel.configureSectionCollectionView(with: 0)
        let southernSection = seaCreaturesViewModel.configureSectionCollectionView(with: 1)
        
        XCTAssertEqual(1, serviceMock.invokedGetSeaCreaturesCount)
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        XCTAssertEqual(2, currentCalendarMock.invockedMakeCurrentCalendarCount)
        XCTAssertEqual(northernSection, 18)
        XCTAssertEqual(southernSection, 17)
    }
    
    func testMakeSeaCreature() {
        currentCalendarMock.stubbedMakeCurrentCalendar = {
            (11, 12)
        }()
        
        serviceMock.stubbedSeaCreatureResult = {
            .success(seaCreatures)
        }()
        seaCreaturesViewModel.getSeaCreaturesData()
        
        let section = 0
        let index = 0
        let seaCreature = seaCreaturesViewModel.makeSeaCreature(with: section, index: index)
        XCTAssertEqual(seaCreature.id, 1)
        XCTAssertEqual(1, serviceMock.invokedGetSeaCreaturesCount)
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        XCTAssertEqual(1, currentCalendarMock.invockedMakeCurrentCalendarCount)
    }
}
