//
//  FossilDetailsTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 31/01/2023.
//

import Foundation

final class FossilDetailsTableViewCellViewModel {
    
    private let fossilData: FossilData
    private let creaturePeeker: CreaturePeeking
    private let creatureWriter: CreatureWriting
    var errorCreatureDatabase: ((String) -> Void) = {_ in}
    
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
        guard let imageURL = URL(string: fossilData.imageURI) else { return nil }
        return imageURL
    }
    
    var price: String {
        String(fossilData.price)
    }
    
    var museumPhrase: String {
        fossilData.museumPhrase
    }
}

extension FossilDetailsTableViewCellViewModel {
    var isFossilAlreadySaved: Bool {
        creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func toggleSavedFossil() -> Bool {
        let isSaved = creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
        if isSaved {
            creatureWriter.deleteCreature(fileName: fileName) { _ in
                self.errorCreatureDatabase("delete_database_error".localized)
            }
        } else {
            creatureWriter.saveCreature(fileName: fileName) { _ in
                self.errorCreatureDatabase("save_database_error".localized)
            }
        }
        return !isSaved
    }
}
