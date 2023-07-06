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
    
    override func setUpWithError() throws {
        sessionMock = NetworkingMock()
        loader = CreatureLoader(session: sessionMock)
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
        XCTAssertEqual(sessionMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/fish/")
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
        XCTAssertEqual(sessionMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/fish/")
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
        XCTAssertEqual(sessionMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/sea/")
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
        XCTAssertEqual(sessionMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/bugs/")
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
        XCTAssertEqual(sessionMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/fossils/")
        waitForExpectations(timeout: 1)
        cancellable.cancel()
    }
}
