//
//  FossilViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 05/07/2023.
//

import XCTest
import Foundation
import Combine
@testable import ACNHGuide

final class FossilViewModelTests: XCTestCase {

    private var loaderMock: CreatureLoaderMock!
    private var fossilViewModel: FossilViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        cancellables.removeAll()
        loaderMock = CreatureLoaderMock()
        fossilViewModel = FossilViewModel(loader: loaderMock)
    }
    
    override func tearDownWithError() throws {
        fossilViewModel = nil
        loaderMock = nil
    }
    
    func testFailureLoadBugs() {
        let expectation = expectation(description: "Failure to load fossils data.")
        loaderMock.stubbedFossilsPublisher = Fail(error: .urlInvalid)
            .eraseToAnyPublisher()
        
        fossilViewModel.failureHandler
            .sink { error in
                XCTAssertEqual(error as! NetworkingError, NetworkingError.urlInvalid)
                XCTAssertEqual(1, self.loaderMock.invokedLoadFossilsData)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        fossilViewModel.loadCreature()
        waitForExpectations(timeout: 1)
    }
    
    func testSuccessLoadBugs() {
        let expectation = expectation(description: "Success to load fossils data.")
        loaderMock.stubbedFossilsPublisher = Result.success(fossils)
            .publisher
            .eraseToAnyPublisher()
        
        fossilViewModel.reloadData
            .sink { _ in
                XCTAssertEqual(self.fossilViewModel.creatures, fossils)
                XCTAssertEqual(1, self.loaderMock.invokedLoadFossilsData)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        fossilViewModel.loadCreature()
        waitForExpectations(timeout: 1)
    }
}
