//
//  DashboardTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 15/02/2023.
//

import Foundation

final class DashboardTableViewCellViewModel {
    
    let fishesData: [FishData]
    let seaCreaturesData: [SeaCreatureData]
    let bugsData: [BugData]
    let fossilsData: [FossilData]
    private var creatureSavedCount = 10
    
    init(fishesData: [FishData], seaCreaturesData: [SeaCreatureData], bugsData: [BugData], fossilsData: [FossilData]) {
        self.fishesData = fishesData
        self.seaCreaturesData = seaCreaturesData
        self.bugsData = bugsData
        self.fossilsData = fossilsData
    }

 
    func configureIconURL(with creatures: Creatures) -> URL? {
        switch creatures {
        case .fishes:
            guard let iconURI = fishesData.first?.iconURI else { return nil }
            return URL(string: iconURI)
        case .seaCreatures:
            guard let iconURI = seaCreaturesData.first?.iconURI else { return nil }
            return URL(string: iconURI)
        case .bugs:
            guard let iconURI = bugsData.first?.iconURI else { return nil }
            return URL(string: iconURI)
        case .fossils:
            guard let imageURI = fossilsData.first?.imageURI else { return nil }
            return URL(string: imageURI)
        }
    }    
    
    func configureTitleText(with creatures: Creatures) -> String {
        switch creatures {
        case .fishes:
            return "fishes".localized
        case .seaCreatures:
            return "sea_creatures".localized
        case .bugs:
            return "bugs".localized
        case .fossils:
            return "fossils".localized
        }
    }
    
    func configureTotalText(with creatures: Creatures) -> String {
        switch creatures {
        case .fishes:
            return "\(creatureSavedCount)/\(fishesData.count)"
        case .seaCreatures:
            return "\(creatureSavedCount)/\(seaCreaturesData.count)"
        case .bugs:
            return "\(creatureSavedCount)/\(bugsData.count)"
        case .fossils:
            return "\(creatureSavedCount)/\(fossilsData.count)"
        }
    }
    
    func configureProgressBar(with creatures: Creatures) -> Float {
        switch creatures {
        case .fishes:
            return Float(creatureSavedCount) / Float(fishesData.count)
        case .seaCreatures:
            return Float(creatureSavedCount) / Float(seaCreaturesData.count)
        case .bugs:
            return Float(creatureSavedCount) / Float(bugsData.count)
        case .fossils:
            return Float(creatureSavedCount) / Float(fossilsData.count)
        }
    }
}
