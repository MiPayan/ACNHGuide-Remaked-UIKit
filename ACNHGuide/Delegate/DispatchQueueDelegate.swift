//
//  DispatchQueueDelegate.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
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
