//
//  BugCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import Foundation

final class BugCollectionViewCellViewModel {
    
    private let bugData: BugData
    private let creatureService = CreatureService(creatures: .bugs)
    
    init(bugData: BugData) {
        self.bugData = bugData
    }

    var fileName: String {
        bugData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var iconURL: URL? {
        URL(string: bugData.iconURI)
    }
    
    var isBugAlreadySaved: Bool {
        creatureService.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func toggleSavedBug() -> Bool {
        let isSaved = creatureService.isCreatureAlreadySaved(fileName: fileName)
        if isSaved {
            creatureService.deleteCreature(fileName: fileName)
        } else {
            creatureService.saveCreature(fileName: fileName)
        }
        return !isSaved
    }
}
