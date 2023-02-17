//
//  FossilDetailsTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 31/01/2023.
//

import Foundation

final class FossilDetailsTableViewCellViewModel {
    
    private let fossilData: FossilData
    
    init(fossilData: FossilData) {
        self.fossilData = fossilData
    }
    
    var filename: String {
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