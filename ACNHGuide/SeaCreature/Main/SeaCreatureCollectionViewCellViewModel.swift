//
//  SeaCreatureCollectionViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 16/02/2023.
//

import Foundation

final class SeaCreatureCollectionViewCellViewModel {
    
    private let seaCreatureData: SeaCreatureData
    
    init(seaCreatureData: SeaCreatureData) {
        self.seaCreatureData = seaCreatureData
    }
    
    var filename: String {
        seaCreatureData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var iconURL: URL? {
        URL(string: seaCreatureData.iconURI)
    }
}
