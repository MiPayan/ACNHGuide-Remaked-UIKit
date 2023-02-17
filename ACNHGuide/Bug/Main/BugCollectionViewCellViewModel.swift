//
//  BugCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import Foundation

final class BugCollectionViewCellViewModel {
    
    let bugData: BugData
    
    init(bugData: BugData) {
        self.bugData = bugData
    }

    var filename: String {
        bugData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var iconURL: URL? {
        URL(string: bugData.iconURI)
    }
}
