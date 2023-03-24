//
//  ACNHServiceTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 07/03/2023.
//

import XCTest
@testable import ACNHGuide

final class ACNHServiceTests: XCTestCase {
    
    private var networkingMock: NetworkingMock<Any>!
    private var service: ACNHService!
    
    override func setUpWithError() throws {
        networkingMock = NetworkingMock()
        service = ACNHService(session: networkingMock)
    }
    
    override func tearDownWithError() throws {
        networkingMock = nil
        service = nil
    }
    
    func testSuccessGetFishesData() {
        let expectation = expectation(description: "Success to get fishes data.")
        networkingMock.stubbedResult = .success(fishes)
        service.getFishesData { result in
            switch result {
            case .success(let fishesData):
                XCTAssertEqual(fishesData, fishes)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
        expectation.fulfill()
        XCTAssertEqual(networkingMock.invokedFetchDataCount, 1)
        XCTAssertEqual(networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/fish/")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFailureGetFishesData() {
        let expectation = expectation(description: "Failure to get fishes data.")
        networkingMock.stubbedResult = .failure(.urlInvalid)
        service.getFishesData { result in
            switch result {
            case .success(let fishesData):
                XCTFail("Unexpected error: \(fishesData)")
            case .failure(let error):
                XCTAssertEqual(error, .urlInvalid)
            }
        }
        expectation.fulfill()
        XCTAssertEqual(networkingMock.invokedFetchDataCount, 1)
        XCTAssertEqual(networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/fish/")
        waitForExpectations(timeout: 1, handler: nil)
    }
}
//    func testSuccessGetSeaCreaturesData() {
//        let expectation = expectation(description: "Success to get sea creatures data.")
//        networkingMock.stubbedResult = .success(seaCreatures)
//        service.getSeaCreaturesData { result in
//            switch result {
//            case .success(let seaCreaturesData):
//                XCTAssertEqual(seaCreaturesData, seaCreatures)
//            case .failure(let error):
//                XCTFail("Unexpected error: \(error)")
//            }
//        }
//        expectation.fulfill()
//        XCTAssertEqual(networkingMock.invokedFetchDataCount, 1)
//        XCTAssertEqual(networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/sea/")
//        waitForExpectations(timeout: 1, handler: nil)
//    }
//    
//    func testFailureGetSeaCreaturesData() {
//        let expectation = expectation(description: "Success to get fishes data.")
//        networkingMock.stubbedResult = .failure(.urlInvalid)
//        service.getSeaCreaturesData { result in
//            switch result {
//            case .success(let seaCreatures):
//                XCTFail("Unexpected error: \(seaCreatures)")
//            case .failure(let error):
//                XCTAssertEqual(error, .urlInvalid)
//            }
//        }
//        expectation.fulfill()
//        XCTAssertEqual(networkingMock.invokedFetchDataCount, 1)
//        XCTAssertEqual(networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/sea/")
//        waitForExpectations(timeout: 1, handler: nil)
//    }
//    
//    func testSuccessGetBugsData() {
//        let expectation = expectation(description: "Success to get bugs data.")
//        networkingMock.stubbedResult = .success(bugs)
//        service.getBugsData { result in
//            switch result {
//            case .success(let bugsData):
//                XCTAssertEqual(bugsData, bugs)
//            case .failure(let error):
//                XCTFail("Unexpected error: \(error)")
//            }
//        }
//        expectation.fulfill()
//        XCTAssertEqual(networkingMock.invokedFetchDataCount, 1)
//        XCTAssertEqual(networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/bugs/")
//        waitForExpectations(timeout: 1, handler: nil)
//    }
//    
//    func testSuccessGetFossilData() {
//        let expectation = expectation(description: "Success to get bugs data.")
//        networkingMock.stubbedResult = .success(fossils)
//        service.getFossilsData { result in
//            switch result {
//            case .success(let fossilsData):
//                XCTAssertEqual(fossilsData, fossils)
//            case .failure(let error):
//                XCTFail("Unexpected error: \(error)")
//            }
//        }
//        expectation.fulfill()
//        XCTAssertEqual(networkingMock.invokedFetchDataCount, 1)
//        XCTAssertEqual(networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/fossils/")
//        waitForExpectations(timeout: 1, handler: nil)
//    }
