//
//  ACNHFishServiceTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 27/03/2023.
//

import XCTest
import Combine
@testable import ACNHGuide

//final class ACNHFishServiceTests: XCTestCase {
//    
//    private var sessionMock: NetworkingMock<FishData>!
//    private var loader: Loader!
//    
//    override func setUpWithError() throws {
//        sessionMock = NetworkingMock()
//        loader = CreatureLoader(session: sessionMock)
//    }
//    
//    override func tearDownWithError() throws {
//        sessionMock = nil
//        loader = nil
//    }
//    
//    func testSuccessGetFishesData() {
//        let expectation = expectation(description: "Success to get fishes data.")
//        networkingMock.stubbedResult = .success(fishes)
//        loader.getFishesData { result in
//            switch result {
//            case .success(let fishesData):
//                XCTAssertEqual(fishesData, fishes)
//            case .failure(let error):
//                XCTFail("Unexpected error: \(error)")
//            }
//            XCTAssertEqual(self.networkingMock.invokedFetchDataCount, 1)
//            XCTAssertEqual(self.networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/fish/")
//            expectation.fulfill()
//        }
//        waitForExpectations(timeout: 1)
//    }
//    
//    func testFailureGetFishesData() {
//        let expectation = expectation(description: "Failure to get fishes data.")
//        networkingMock.stubbedResult = .failure(.urlInvalid)
//        loader.getFishesData { result in
//            switch result {
//            case .success(let fishesData):
//                XCTFail("Unexpected error: \(fishesData)")
//            case .failure(let error):
//                XCTAssertEqual(error, .urlInvalid)
//            }
//            XCTAssertEqual(self.networkingMock.invokedFetchDataCount, 1)
//            XCTAssertEqual(self.networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/fish/")
//            expectation.fulfill()
//        }
//        waitForExpectations(timeout: 1)
//    }
//}
