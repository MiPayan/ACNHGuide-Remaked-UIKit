//
//  DispatchQueueMock.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

@testable import ACNHGuide

final class DispatchQueueMock: DispatchQueueDelegate {
    
    var invokedAsyncCount = 0
    
    func async(execute work: @escaping @convention(block) () -> Void) {
        invokedAsyncCount += 1
        return work()
    }
}
