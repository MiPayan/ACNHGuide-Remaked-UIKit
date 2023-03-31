//
//  ACNHFossilServiceTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 27/03/2023.
//

import XCTest
@testable import ACNHGuide

final class ACNHFossilServiceTests: XCTestCase {
    
    private var networkingMock: NetworkingMock<FossilData>!
    private var service: ACNHService!
    
    override func setUpWithError() throws {
        networkingMock = NetworkingMock()
        service = ACNHService(session: networkingMock)
    }
    
    override func tearDownWithError() throws {
        networkingMock = nil
        service = nil
    }
    
    func testSuccessGetBugsData() {
        let expectation = expectation(description: "Success to get fishes data.")
        networkingMock.stubbedResult = .success(fossils)
        service.getFossilsData { result in
            switch result {
            case .success(let fossilsData):
                XCTAssertEqual(fossilsData, fossils)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
            XCTAssertEqual(self.networkingMock.invokedFetchDataCount, 1)
            XCTAssertEqual(self.networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/fossils/")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFailureGetBugsData() {
        let expectation = expectation(description: "Failure to get fishes data.")
        networkingMock.stubbedResult = .failure(.error)
        service.getFossilsData { result in
            switch result {
            case .success(let fossilsData):
                XCTFail("Unexpected error: \(fossilsData)")
            case .failure(let error):
                XCTAssertEqual(error, .error)
            }
            XCTAssertEqual(self.networkingMock.invokedFetchDataCount, 1)
            XCTAssertEqual(self.networkingMock.stubbedFetchDataUrlStringParameter, "https://acnhapi.com/v1a/fossils/")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
