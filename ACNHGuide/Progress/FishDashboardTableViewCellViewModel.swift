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
    
    init(
        fishesData: [FishData],
        creaturePeeker: CreaturePeeking = FishService(),
        creatureWriter: CreatureWriting = FishService()
    ) {
        self.fishesData = fishesData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
    }
    
    var fishesSavedCount: Int {
        creaturePeeker.creaturesSaved.count
    }
    
    var iconURL: URL? {
        guard let iconURI = fishesData.first?.iconURI else { return nil }
        return URL(string: iconURI)
    }
    
    var titleText: String {
        "fishes".localized
    }
    
    var totalText: String {
        "\(fishesSavedCount)/\(fishesData.count)"
    }
    
    var progressBarState: Float {
         Float(fishesSavedCount) / Float(fishesData.count)
    }
}
