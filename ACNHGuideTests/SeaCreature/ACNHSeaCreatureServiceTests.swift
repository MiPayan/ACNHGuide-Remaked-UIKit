//
//  ACNHSeaCreatureServiceTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 27/03/2023.
//

import XCTest
@testable import ACNHGuide

final class ACNHSeaCreatureServiceTests: XCTestCase {
    
    private var networkingMock: NetworkingMock<SeaCreatureData>!
    private var service: CreatureLoader!
    
    override func setUpWithError() throws {
        networkingMock = NetworkingMock()
        service = CreatureLoader(session: networkingMock)
    }
    
    override func tearDownWithError() throws {
        networkingMock = nil
        service = nil
    }
    
    func testSuccessGetSeaCreaturesData() {
        let expectation = expectation(description: "Success to get sea creatures data.")
        networkingMock.stubbedResult = .success(seaCreatures)
        service.getSeaCreaturesData { result in
            switch result {
            case .success(let seaCreaturesData):
                XCTAssertEqual(seaCreaturesData, seaCreatures)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
            XCTAssertEqual(self.networkingMock.invokedFetchDataCount, 1)
            XCTAssertEqual(self.networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/sea/")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func testFailureGetSeaCreaturesData() {
        let expectation = expectation(description: "Failure to get sea creatures data.")
        networkingMock.stubbedResult = .failure(.noData)
        service.getSeaCreaturesData { result in
            switch result {
            case .success(let seaCreaturesData):
                XCTFail("Unexpected error: \(seaCreaturesData)")
            case .failure(let error):
                XCTAssertEqual(error, .noData)
            }
            XCTAssertEqual(self.networkingMock.invokedFetchDataCount, 1)
            XCTAssertEqual(self.networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/sea/")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
