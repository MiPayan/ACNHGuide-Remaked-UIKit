//
//  FishesTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 07/06/2023.
//

import Foundation

final class FishesTableViewCellViewModel {
    
    private(set) var fishesData: [FishData]
    
    init(fishesData: [FishData]) {
        self.fishesData = fishesData
    }
    
    func makeSubTitle(with subTitleText: String) -> String {
        subTitleText
    }
}

extension FishesTableViewCellViewModel {
    var numberOfItemsInSection : Int {
        min(fishesData.count, 10)
    }
    
    func makeFish(at index: Int) -> FishData {
        guard index < 10 && index < fishesData.count else {
            return fishesData[0]
        }
        return fishesData[index]
    }
}
