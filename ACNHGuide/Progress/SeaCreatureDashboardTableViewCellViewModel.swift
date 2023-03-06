//
//  SeaCreatureDashboardTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 02/03/2023.
//

import Foundation

final class SeaCreatureDashboardTableViewCellViewModel {
    
    private let seaCreaturesData: [SeaCreatureData]
    private let creaturePeeker: CreaturePeeking
    private let creatureWriter: CreatureWriting
    let titleText = "sea_creatures".localized
    
    init(
        seaCreaturesData: [SeaCreatureData],
        creaturePeeker: CreaturePeeking = SeaCreatureService(),
        creatureWriter: CreatureWriting = SeaCreatureService()
    ) {
        self.seaCreaturesData = seaCreaturesData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
    }
    
    private var seaCreaturesSavedCount: Int {
        creaturePeeker.creaturesSaved.count
    }
    
    var iconURL: URL? {
        guard let iconURI = seaCreaturesData.first?.iconURI else { return nil }
        return URL(string: iconURI)
    }
    

    
    var totalText: String {
        "\(seaCreaturesSavedCount)/\(seaCreaturesData.count)"
    }
    
    var progressOfBar: Float {
         Float(seaCreaturesSavedCount) / Float(seaCreaturesData.count)
    }
}
