//
//  BugCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import Foundation

final class BugCollectionViewCellViewModel {
    
    private let bugData: BugData
    private let creaturePeeker: CreaturePeeking
    private let creatureWriter: CreatureWriting
    
    init(
        bugData: BugData,
        creaturePeeker: CreaturePeeking = BugService(),
        creatureWriter: CreatureWriting = BugService()
    ) {
        self.bugData = bugData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
    }
    
    var fileName: String {
        bugData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var iconURL: URL? {
        URL(string: bugData.iconURI)
    }
}

extension BugCollectionViewCellViewModel {
    var isBugAlreadySaved: Bool {
        creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func toggleSavedBug() -> Bool {
        let isSaved = creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
        if isSaved {
            creatureWriter.deleteCreature(fileName: fileName)
        } else {
            creatureWriter.saveCreature(fileName: fileName)
        }
        return !isSaved
    }
}
