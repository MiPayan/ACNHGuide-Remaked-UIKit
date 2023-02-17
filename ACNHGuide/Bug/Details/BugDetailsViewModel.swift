//
//  BugDetailsViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 14/02/2023.
//

import Foundation

final class BugDetailsViewModel {
    
    let bugData: BugData
    let numberOfRowsInSection = 1
    
    init(bugData: BugData) {
        self.bugData = bugData
    }
}
