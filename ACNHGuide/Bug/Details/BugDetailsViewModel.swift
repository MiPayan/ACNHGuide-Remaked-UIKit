//
//  BugDetailsViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 31/01/2023.
//

import Foundation

final class BugDetailsViewModel {
    
    private let bugData: BugData
    
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
}
