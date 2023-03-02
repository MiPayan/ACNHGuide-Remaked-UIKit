//
//  DashboardTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 15/02/2023.
//

import Foundation

final class DashboardTableViewCellViewModel {
    
    private let fishesData: [FishData]
    private let seaCreaturesData: [SeaCreatureData]
    private let bugsData: [BugData]
    private let fossilsData: [FossilData]
    private var creatureSavedCount = 10
    
    private var fishesSavedCount: Int {
        let fishService = FishService()
        return fishService.creaturesSaved.count
    }
    
    private var seaCreaturesSavedCount: Int {
        let seaCreatureService = SeaCreatureService()
        return seaCreatureService.creaturesSaved.count
    }
    
    private var bugsSavedCount: Int {
        let bugService = BugService()
        return bugService.creaturesSaved.count
    }
    
    private var fossilsSavedCount: Int {
        let fossilService = FossilService()
        return fossilService.creaturesSaved.count
    }
    
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
            return "\(fishesSavedCount)/\(fishesData.count)"
        case .seaCreatures:
            return "\(seaCreaturesSavedCount)/\(seaCreaturesData.count)"
        case .bugs:
            return "\(bugsSavedCount)/\(bugsData.count)"
        case .fossils:
            return "\(fossilsSavedCount)/\(fossilsData.count)"
        }
    }
    
    func configureProgressBar(with creatures: Creatures) -> Float {
        switch creatures {
        case .fishes:
            return Float(fishesSavedCount) / Float(fishesData.count)
        case .seaCreatures:
            return Float(seaCreaturesSavedCount) / Float(seaCreaturesData.count)
        case .bugs:
            return Float(bugsSavedCount) / Float(bugsData.count)
        case .fossils:
            return Float(fossilsSavedCount) / Float(fossilsData.count)
        }
    }
}
