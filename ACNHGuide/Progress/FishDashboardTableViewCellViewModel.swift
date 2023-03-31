//
//  FishDashboardTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 02/03/2023.
//

import Foundation

final class FishDashboardTableViewCellViewModel {
    
    private let fishesData: [FishData]
    private let creaturePeeker: CreaturePeeking
    private let creatureWriter: CreatureWriting
    let titleText = "fishes".localized
    
    init(
        fishesData: [FishData],
        creaturePeeker: CreaturePeeking = FishService(),
        creatureWriter: CreatureWriting = FishService()
    ) {
        self.fishesData = fishesData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
    }
    
    private var fishesSavedCount: Int {
        creaturePeeker.creaturesSaved.count
    }
    
    var iconURL: URL? {
        guard let iconURI = fishesData.first?.iconURI else { return nil }
        return URL(string: iconURI)
    }
    
    var totalText: String {
        "\(fishesSavedCount)/\(fishesData.count)"
    }
    
    var progressOfBar: Float {
        Float(fishesSavedCount) / Float(fishesData.count)
    }
}
