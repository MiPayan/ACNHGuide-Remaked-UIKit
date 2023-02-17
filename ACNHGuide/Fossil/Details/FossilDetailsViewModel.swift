//
//  FossilDetailsViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 14/02/2023.
//

import Foundation

final class FossilDetailsViewModel {
    
    let fossilData: FossilData
    let numberOfRowsInSection = 1
    
    init(fossilData: FossilData) {
        self.fossilData = fossilData
    }
}
