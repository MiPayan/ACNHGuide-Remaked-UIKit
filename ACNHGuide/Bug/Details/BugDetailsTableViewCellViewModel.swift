//
//  BugDetailsTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 31/01/2023.
//

import Foundation

final class BugDetailsTableViewCellViewModel {
    
    private let bugData: BugData
    private let creaturePeeker: CreaturePeeking
    private let creatureWriter: CreatureWriting
    let numberOfItemsInSection = 7
    var errorCreatureDatabase: ((String) -> Void) = {_ in}
    
    init(
        bugData: BugData,
        creaturePeeker: CreaturePeeking = BugService(),
        creatureWriter: CreatureWriting = BugService()
    ) {
        self.bugData = bugData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
    }
    
    var fileName: String {
        bugData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var iconURL: URL? {
        guard let iconURL = URL(string: bugData.iconURI) else { return nil }
        return iconURL
    }
    
    var catchPhrase: String {
        "\" \(bugData.catchPhrase) \""
    }
    
    var museumPhrase: String {
        bugData.museumPhrase
    }
    
    func makeImageName(at index: Int) -> String {
        ["Bells", "Flick", "Grass", "Timer", "Rarity", "North", "South"][index]
    }
    
    func makeTitle(at index: Int) -> String {
        [
            "price".localized,
            "price_flick".localized,
            "location".localized,
            "time".localized,
            "rarity".localized,
            "northern_hemisphere".localized,
            "southern_hemisphere".localized
        ][index]
    }
    
    func makeValue(at index: Int) -> String {
        [
            price,
            priceFlick,
            availabilityLocation,
            availabilityTime,
            rarity,
            northernHemisphereAvailability,
            southernHemisphereAvailability
        ][index]
    }
}

private extension BugDetailsTableViewCellViewModel {
    var price: String {
        String(bugData.price)
    }
    
    var priceFlick: String {
        String(bugData.priceFlick)
    }
    
    var availabilityLocation: String {
        bugData.availability.location
    }
    
    var availabilityTime: String {
        bugData.availability.time.isEmpty ? "availibility_always".localized : bugData.availability.time
    }
    
    var rarity: String {
        bugData.availability.rarity
    }
    
    var northernHemisphereAvailability: String {
        bugData.availability.monthNorthern.isEmpty ? "availibility_always".localized : bugData.availability.monthNorthern
    }
    
    var southernHemisphereAvailability: String {
        bugData.availability.monthSouthern.isEmpty ? "availibility_always".localized : bugData.availability.monthSouthern
    }
}

extension BugDetailsTableViewCellViewModel {
    var isBugAlreadySaved: Bool {
        creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func toggleSavedBug() -> Bool {
        let isSaved = creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
        if isSaved {
            creatureWriter.deleteCreature(fileName: fileName) { [weak self] _ in
                guard let self = self else { return }
                self.errorCreatureDatabase("delete_database_error".localized)
            }
        } else {
            creatureWriter.saveCreature(fileName: fileName) { _ in
                self.errorCreatureDatabase("save_database_error".localized)
            }
        }
        return !isSaved
    }
}
