//
//  BugDetailsTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 31/01/2023.
//

import Foundation

final class BugDetailsTableViewCellViewModel {
    
    private let bugData: BugData
    private let creatureService = CreatureService(creatures: .bugs)
    let numberOfItemsInSection = 6
    
    init(bugData: BugData) {
        self.bugData = bugData
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
        
    var price: String {
        String(bugData.price)
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
    
    var museumPhrase: String {
        bugData.museumPhrase
    }
    
    func makeImageName(at index: Int) -> String {
        ["Bells", "Grass", "Timer", "Rarity", "North", "South"][index]
    }
    
    var isBugAlreadySaved: Bool {
        creatureService.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func makeTitle(at index: Int) -> String {
        [
            "price".localized,
            "location".localized,
            "time".localized,
            "rarity".localized,
            "northern_hemisphere".localized,
            "southern_hemisphere".localized
        ][index]
    }
    
    func makeValue(at index: Int) -> String {
        [price, availabilityLocation, availabilityTime, rarity, northernHemisphereAvailability, southernHemisphereAvailability][index]
    }

    func toggleSavedBug() -> Bool {
        let isSaved = creatureService.isCreatureAlreadySaved(fileName: fileName)
        if isSaved {
            creatureService.deleteCreature(fileName: fileName)
        } else {
            creatureService.saveCreature(fileName: fileName)
        }
        return !isSaved
    }
}
