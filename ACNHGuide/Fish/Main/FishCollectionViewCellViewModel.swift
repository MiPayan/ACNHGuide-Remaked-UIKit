//
//  FishCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import Foundation

final class FishCollectionViewCellViewModel {
    
    private let fishData: FishData
    
    init(fishData: FishData) {
        self.fishData = fishData
    }
    
    var filename: String {
        fishData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var iconURL: URL? {
        URL(string: fishData.iconURI)
    }
}
