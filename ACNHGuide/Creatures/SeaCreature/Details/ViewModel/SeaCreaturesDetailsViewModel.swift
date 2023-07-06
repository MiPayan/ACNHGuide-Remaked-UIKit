//
//  SeaCreaturesDetailsViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 14/02/2023.
//

import Foundation

final class SeaCreaturesDetailsViewModel {
    
    let seaCreatureData: SeaCreatureData
    let numberOfRowsInSection = 1
    
    init(seaCreatureData: SeaCreatureData) {
        self.seaCreatureData = seaCreatureData
    }
}
