//
//  FishesCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 07/06/2023.
//

import Foundation

final class FishesCollectionViewCellViewModel {
    
    private let fishData: FishData
    
    init(fishData: FishData) {
        self.fishData = fishData
    }
    
    var fileName: String {
        fishData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var iconURL: URL? {
        URL(string: fishData.iconURI)
    }
}
