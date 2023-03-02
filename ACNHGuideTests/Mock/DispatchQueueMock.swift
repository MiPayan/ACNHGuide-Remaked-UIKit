//
//  DispatchQueueMock.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

import XCTest
@testable import ACNHGuide

final class DispatchQueueMock: DispatchQueueDelegate {
    
    var invokedAsyncCount = 0
    
    func async(execute work: @escaping @convention(block) () -> Void) {
        invokedAsyncCount += 1
        return work()
    }
}
