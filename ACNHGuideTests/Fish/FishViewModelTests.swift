//
//  FishViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

import XCTest
@testable import ACNHGuide

final class FishViewModelTests: XCTestCase {
    
    private var serviceMock: CreatureServicesMock!
    private var dispatchQueueMock: DispatchQueueMock!
    private var currentCalendarMock: CurrentCalendarMock!
    private var fishesViewModel: FishViewModel!
    
    override func setUpWithError() throws {
        serviceMock = CreatureServicesMock()
        dispatchQueueMock = DispatchQueueMock()
        currentCalendarMock = CurrentCalendarMock()
        fishesViewModel = FishViewModel(
            service: serviceMock,
            mainDispatchQueue: dispatchQueueMock,
            currentCalendar: currentCalendarMock
        )
    }
    
    override func tearDownWithError() throws {
        currentCalendarMock = nil
        dispatchQueueMock = nil
        fishesViewModel = nil
        serviceMock = nil
    }
    
    func testFailureGetFishes() {
        let expectation = expectation(description: "Failure to get fishes.")
        serviceMock.stubbedFishResult = (
            .failure(.urlInvalid)
        )
        
        fishesViewModel.errorSubject = {
            XCTAssertEqual(1, self.serviceMock.invokedGetFishesCount)
            expectation.fulfill()
        }
        fishesViewModel.getFishesData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1)
    }
    
    func testSuccessGetFishes() {
        let expectation = expectation(description: "Success to get fishes.")
        serviceMock.stubbedFishResult = (
            .success(fishes)
        )
        
        fishesViewModel.successHandler = {
            XCTAssertEqual(1, self.serviceMock.invokedGetFishesCount)
            expectation.fulfill()
        }
        fishesViewModel.getFishesData()
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        waitForExpectations(timeout: 1)
    }
    
    func testSetHeaderSection() {
        let northernSectionHeader = fishesViewModel.configureHeaderSection(with: 0)
        let southernSectionHeader = fishesViewModel.configureHeaderSection(with: 1)
        XCTAssertEqual(northernSectionHeader, "Northern hemisphere")
        XCTAssertEqual(southernSectionHeader, "Southern hemisphere")
    }
    
    func testConfigureSectionCollectionView() {
        currentCalendarMock.stubbedMakeCurrentCalendar = {
            (11, 12)
        }()
        
        serviceMock.stubbedFishResult = {
            .success(fishes)
        }()
        
        fishesViewModel.getFishesData()
        
        let northernSection = fishesViewModel.configureSectionCollectionView(with: 0)
        let southernSection = fishesViewModel.configureSectionCollectionView(with: 1)
        
        XCTAssertEqual(1, serviceMock.invokedGetFishesCount)
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        XCTAssertEqual(2, currentCalendarMock.invockedMakeCurrentCalendarCount)
        XCTAssertEqual(northernSection, 25)
        XCTAssertEqual(southernSection, 39)
    }
    
    func testMakeFish() {
        currentCalendarMock.stubbedMakeCurrentCalendar = {
            (11, 12)
        }()
        
        serviceMock.stubbedFishResult = {
            .success(fishes)
        }()
        fishesViewModel.getFishesData()
        
        let section = 0
        let index = 0
        let fish = fishesViewModel.makeFish(with: section, index: index)
        XCTAssertEqual(fish.id, 1)
        XCTAssertEqual(1, serviceMock.invokedGetFishesCount)
        XCTAssertEqual(1, dispatchQueueMock.invokedAsyncCount)
        XCTAssertEqual(1, currentCalendarMock.invockedMakeCurrentCalendarCount)
    }
}
