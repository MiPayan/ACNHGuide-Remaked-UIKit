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
    let titleText = "fossils".localized
    
    init(
        fossilsData: [FossilData],
        creaturePeeker: CreaturePeeking = FossilService(),
        creatureWriter: CreatureWriting = FossilService()
    ) {
        self.fossilsData = fossilsData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
    }
    
    private var fossilsSavedCount: Int {
        creaturePeeker.creaturesSaved.count
    }
    
    var imageURL: URL? {
        guard let imageURI = fossilsData.first?.imageURI else { return nil }
        return URL(string: imageURI)
    }
    
    var totalText: String {
        "\(fossilsSavedCount)/\(fossilsData.count)"
    }
    
    var progressOfBar: Float {
         Float(fossilsSavedCount) / Float(fossilsData.count)
    }
}
