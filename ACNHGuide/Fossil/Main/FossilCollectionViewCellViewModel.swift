//
//  FossilCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import Foundation

final class FossilCollectionViewCellViewModel {
    
    private let fossilData: FossilData
    
    init(fossilData: FossilData) {
        self.fossilData = fossilData
    }
    
    var filename: String {
        fossilData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var imageURL: URL? {
        URL(string: fossilData.imageURI)
    }
}
