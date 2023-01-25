//
//  DispatchQueue.swift
//  ACNHS
//
//  Created by Mickael PAYAN on 12/12/2022.
//

import Foundation

protocol DispatchQueueProtocol {
    func async(execute work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue: DispatchQueueProtocol {
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, execute: work)
    }
}
