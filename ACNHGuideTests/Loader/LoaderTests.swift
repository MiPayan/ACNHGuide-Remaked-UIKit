//
//  LoaderTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 27/03/2023.
//

import XCTest
import Combine
@testable import ACNHGuide

final class LoaderTests: XCTestCase {
    
    private var sessionMock: NetworkingMock!
    private var loader: Loader!
    
    // Le bundle de tests ne contient pas les copies embarquées : le repli hors ligne
    // est donc inactif ici, sauf dans le test qui le vise explicitement.
    private var bundleWithoutOfflineData: Bundle {
        Bundle(for: type(of: self))
    }
    
    override func setUpWithError() throws {
        sessionMock = NetworkingMock()
        loader = CreatureLoader(session: sessionMock, bundle: bundleWithoutOfflineData)
    }
    
    override func tearDownWithError() throws {
        sessionMock = nil
        loader = nil
    }
    
//    MARK: - Fishes
    
    func testFailureLoadData() {
        let expectation = expectation(description: "Failure to load fishes data.")
        sessionMock.stubbedFishData = Fail(error: .decodingFailure)
            .eraseToAnyPublisher()
        
        let publisher = loader.loadFishesData()
        
        let cancellable = publisher.sink { completion in
            switch completion {
            case .finished:
                XCTFail("Unexpected completion: finished")
            case .failure(let error):
                XCTAssertEqual(error, .decodingFailure)
                expectation.fulfill()
            }
        } receiveValue: { _ in }
        
        XCTAssertEqual(sessionMock.invokedFetchDataCount, 1)
        XCTAssertEqual(sessionMock.stubbedFetchDataUrlStringParameter, "https://raw.githubusercontent.com/alexislours/ACNHAPI/6df0d7318a97/v1a/fish.json")
        waitForExpectations(timeout: 1)
        cancellable.cancel()
    }
    
    func testFallbackOnBundledDataWhenRequestFails() {
        let expectation = expectation(description: "Fallback on bundled fishes data.")
        let loaderWithOfflineData = CreatureLoader(session: sessionMock, bundle: .main)
        sessionMock.stubbedFishData = Fail(error: .unreachable)
            .eraseToAnyPublisher()
        
        let cancellable = loaderWithOfflineData.loadFishesData().sink { completion in
            if case .failure = completion {
                XCTFail("Unexpected completion: failure")
            }
        } receiveValue: { fishesData in
            XCTAssertEqual(fishesData.count, 80)
            XCTAssertEqual(fishesData.first?.fileName, "bitterling")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        cancellable.cancel()
    }
    
    func testSuccessLoadFishesData() {
        let expectation = expectation(description: "Success to load fishes data.")
        sessionMock.stubbedFishData = Result.success(fishes)
            .publisher
            .eraseToAnyPublisher()
        
        let publisher = loader.loadFishesData()
        
        let cancellable = publisher.sink { _ in } receiveValue: { fishesData in
            XCTAssertEqual(fishesData, fishes)
            expectation.fulfill()
        }
        
        XCTAssertEqual(sessionMock.invokedFetchDataCount, 1)
        XCTAssertEqual(sessionMock.stubbedFetchDataUrlStringParameter, "https://raw.githubusercontent.com/alexislours/ACNHAPI/6df0d7318a97/v1a/fish.json")
        waitForExpectations(timeout: 1)
        cancellable.cancel()
    }
    
    //    MARK: - SeaCreatures
    
    func testSuccessLoadSeaCreaturesData() {
        let expectation = expectation(description: "Success to load sea creatures data.")
        sessionMock.stubbedSeaCreatureData = Result.success(seaCreatures)
            .publisher
            .eraseToAnyPublisher()
        
        let publisher = loader.loadSeaCreaturesData()
        
        let cancellable = publisher.sink { _ in } receiveValue: { seaCreaturesData in
            XCTAssertEqual(seaCreaturesData, seaCreatures)
            expectation.fulfill()
        }
        
        XCTAssertEqual(sessionMock.invokedFetchDataCount, 1)
        XCTAssertEqual(sessionMock.stubbedFetchDataUrlStringParameter, "https://raw.githubusercontent.com/alexislours/ACNHAPI/6df0d7318a97/v1a/sea.json")
        waitForExpectations(timeout: 1)
        cancellable.cancel()
    }
    
    //    MARK: - Bugs
    
    func testSuccessLoadBugsData() {
        let expectation = expectation(description: "Success to load bugs data.")
        sessionMock.stubbedBugData = Result.success(bugs)
            .publisher
            .eraseToAnyPublisher()
        
        let publisher = loader.loadBugsData()
        
        let cancellable = publisher.sink { _ in } receiveValue: { bugsData in
            XCTAssertEqual(bugsData, bugs)
            expectation.fulfill()
        }
        
        XCTAssertEqual(sessionMock.invokedFetchDataCount, 1)
        XCTAssertEqual(sessionMock.stubbedFetchDataUrlStringParameter, "https://raw.githubusercontent.com/alexislours/ACNHAPI/6df0d7318a97/v1a/bugs.json")
        waitForExpectations(timeout: 1)
        cancellable.cancel()
    }
    
    //    MARK: - Fossils
    
    func testSuccessLoadFossilssData() {
        let expectation = expectation(description: "Success to load fossils data.")
        sessionMock.stubbedFossilData = Result.success(fossils)
            .publisher
            .eraseToAnyPublisher()
        
        let publisher = loader.loadFossilsData()
        
        let cancellable = publisher.sink { _ in } receiveValue: { fossilsData in
            XCTAssertEqual(fossilsData, fossils)
            expectation.fulfill()
        }
        
        XCTAssertEqual(sessionMock.invokedFetchDataCount, 1)
        XCTAssertEqual(sessionMock.stubbedFetchDataUrlStringParameter, "https://raw.githubusercontent.com/alexislours/ACNHAPI/6df0d7318a97/v1a/fossils.json")
        waitForExpectations(timeout: 1)
        cancellable.cancel()
    }
}
