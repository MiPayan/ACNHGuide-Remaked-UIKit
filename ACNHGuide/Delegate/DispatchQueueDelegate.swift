//
//  DispatchQueueDelegate.swift
//  ACNHS
//
//  Created by Mickael PAYAN on 12/12/2022.
//

import Foundation

protocol DispatchQueueDelegate {
    func async(execute work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue: DispatchQueueDelegate {
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, execute: work)
    }
}
