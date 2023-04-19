//
//  ACNHBugServiceTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 27/03/2023.
//

import XCTest
@testable import ACNHGuide

final class ACNHBugServiceTests: XCTestCase {

    private var networkingMock: NetworkingMock<BugData>!
    private var service: CreatureService!
    
    override func setUpWithError() throws {
        networkingMock = NetworkingMock()
        service = CreatureService(session: networkingMock)
    }
    
    override func tearDownWithError() throws {
        networkingMock = nil
        service = nil
    }
    
    func testSuccessGetBugsData() {
        let expectation = expectation(description: "Success to get bugs data.")
        networkingMock.stubbedResult = .success(bugs)
        service.getBugsData { result in
            switch result {
            case .success(let bugsData):
                XCTAssertEqual(bugsData, bugs)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
            XCTAssertEqual(self.networkingMock.invokedFetchDataCount, 1)
            XCTAssertEqual(self.networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/bugs/")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func testFailureGetBugsData() {
        let expectation = expectation(description: "Failure to get bugs data.")
        networkingMock.stubbedResult = .failure(.decodingFailure)
        service.getBugsData { result in
            switch result {
            case .success(let seaCreaturesData):
                XCTFail("Unexpected error: \(seaCreaturesData)")
            case .failure(let error):
                XCTAssertEqual(error, .decodingFailure)
            }
            XCTAssertEqual(self.networkingMock.invokedFetchDataCount, 1)
            XCTAssertEqual(self.networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/bugs/")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
