//
//  FishDetailsViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/02/2023.
//

import Foundation

final class FishDetailsViewModel {
    
    let fishData: FishData
    let numberOfRowsInSection = 1
    
    init(fishData: FishData) {
        self.fishData = fishData
    }
}
