//
//  BugDashboardTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 02/03/2023.
//

import Foundation

final class BugDashboardTableViewCellViewModel {
    
    private let bugsData: [BugData]
    private let creaturePeeker: CreaturePeeking
    private let creatureWriter: CreatureWriting
    let titleText = "bugs".localized
    
    init(
        bugsData: [BugData],
        creaturePeeker: CreaturePeeking = BugService(),
        creatureWriter: CreatureWriting = BugService()
    ) {
        self.bugsData = bugsData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
    }
    
    private var bugsSavedCount: Int {
        creaturePeeker.creaturesSaved.count
    }
    
    var iconURL: URL? {
        guard let iconURI = bugsData.first?.iconURI else { return nil }
        return URL(string: iconURI)
    }
    
    var totalText: String {
        "\(bugsSavedCount)/\(bugsData.count)"
    }
    
    var progressOfBar: Float {
        Float(bugsSavedCount) / Float(bugsData.count)
    }
}
