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
        
        seaCreaturesViewModel.failureHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetSeaCreaturesCount)
            expectation.fulfill()
        }
        seaCreaturesViewModel.getSeaCreatureData()
        waitForExpectations(timeout: 1, handler: nil)
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
        seaCreaturesViewModel.getSeaCreatureData()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    
    func testSetHeaderSection() {
        let northernSectionHeader = seaCreaturesViewModel.setHeaderSection(with: 0)
        let southernSectionHeader = seaCreaturesViewModel.setHeaderSection(with: 1)
        XCTAssertEqual(northernSectionHeader, "Northern hemisphere")
        XCTAssertEqual(southernSectionHeader, "Southern hemisphere")
    }
    
    func testConfigureSectionCollectionView() {
        let expectation = expectation(description: "Sort fishes.")
        currentCalendarMock.stubbedMakeCurrentCalendar = {
            (11, 12)
        }()
        
        serviceMock.stubbedSeaCreatureResult = {
            .success(seaCreatures)
        }()
        
        seaCreaturesViewModel.successHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetSeaCreaturesCount)
        }
        
        seaCreaturesViewModel.getSeaCreatureData()
        
        let northernSection = seaCreaturesViewModel.configureSectionCollectionView(with: 0)
        let southernSection = seaCreaturesViewModel.configureSectionCollectionView(with: 1)
        
        XCTAssertEqual(2, currentCalendarMock.invockedMakeCurrentCalendarCount)
        XCTAssertEqual(northernSection, 18)
        XCTAssertEqual(southernSection, 17)
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
    }
}
