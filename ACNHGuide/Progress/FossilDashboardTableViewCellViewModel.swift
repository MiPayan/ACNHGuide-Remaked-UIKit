//
//  FossilDashboardTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 02/03/2023.
//

import Foundation

final class FossilDashboardTableViewCellViewModel {
    
    private let fossilsData: [FossilData]
    private let creaturePeeker: CreaturePeeking
    private let creatureWriter: CreatureWriting
    
    init(
        fossilsData: [FossilData],
        creaturePeeker: CreaturePeeking = SeaCreatureService(),
        creatureWriter: CreatureWriting = SeaCreatureService()
    ) {
        self.fossilsData = fossilsData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
    }
    
    var fossilsSavedCount: Int {
        creaturePeeker.creaturesSaved.count
    }
    
    var imageURL: URL? {
        guard let imageURI = fossilsData.first?.imageURI else { return nil }
        return URL(string: imageURI)
    }
    
    var titleText: String {
        "fossils".localized
    }
    
    var totalText: String {
        "\(fossilsSavedCount)/\(fossilsData.count)"
    }
    
    var progressBarState: Float {
         Float(fossilsSavedCount) / Float(fossilsData.count)
    }
}
