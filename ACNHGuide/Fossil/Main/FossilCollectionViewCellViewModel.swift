//
//  FossilCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import Foundation

final class FossilCollectionViewCellViewModel {
    
    private let fossilData: FossilData
    private let creaturePeeker: CreaturePeeking
    private let creatureWriter: CreatureWriting
    
    init(
        fossilData: FossilData,
        creaturePeeker: CreaturePeeking = FossilService(),
        creatureWriter: CreatureWriting = FossilService()
    ) {
        self.fossilData = fossilData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
    }
    
    var fileName: String {
        fossilData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var imageURL: URL? {
        URL(string: fossilData.imageURI)
    }
}

extension FossilCollectionViewCellViewModel {
    var isFossilAlreadySaved: Bool {
        creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func toggleSavedFossil() -> Bool {
        let isSaved = creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
        if isSaved {
            creatureWriter.deleteCreature(fileName: fileName)
        } else {
            creatureWriter.saveCreature(fileName: fileName)
        }
        return !isSaved
    }
}
