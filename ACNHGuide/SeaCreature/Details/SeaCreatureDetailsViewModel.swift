//
//  SeaCreatureDetailsViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 31/01/2023.
//

import Foundation

final class SeaCreatureDetailsViewModel {
    
    private let seaCreatureData: SeaCreatureData
    
    init(seaCreatureData: SeaCreatureData) {
        self.seaCreatureData = seaCreatureData
    }
    
    var fileName: String {
        seaCreatureData.fileName.replaceCharacter("_", by: " ").capitalized
    }
    
    var iconURL: URL? {
        guard let iconURL = URL(string: seaCreatureData.iconURI) else { return nil }
        return iconURL
    }
    
    var catchPhrase: String {
        "\" \(seaCreatureData.catchPhrase) \""
    }
    
    var price: String {
        String(seaCreatureData.price)
    }
    
    var shadow: String {
        seaCreatureData.shadow
    }
    
    var availabilityTime: String {
        seaCreatureData.availability.time.isEmpty ? "availibility_always".localized : seaCreatureData.availability.time
    }
    
    var speed: String {
        seaCreatureData.speed
    }
    
    var northernHemisphereAvailability: String {
        seaCreatureData.availability.monthNorthern.isEmpty ? "availibility_always".localized : seaCreatureData.availability.monthNorthern
    }
    
    var southernHemisphereAvailability: String {
        seaCreatureData.availability.monthSouthern.isEmpty ? "availibility_always".localized : seaCreatureData.availability.monthSouthern
    }
    
    var museumPhrase: String {
        seaCreatureData.museumPhrase
    }
    
    func makeImageName(at index: Int) -> String {
        ["Bells", "SeaCreatureShadow", "Timer", "Speedmeter", "North", "South"][index]
    }
    
    func makeTitle(at index: Int) -> String {
        [
            "price".localized,
            "shadow".localized,
            "time".localized,
            "speed".localized,
            "northern_hemisphere".localized,
            "southern_hemisphere".localized
        ][index]
    }
    
    func makeValue(at index: Int) -> String {
        [price, shadow, availabilityTime, speed, northernHemisphereAvailability, southernHemisphereAvailability][index]
    }
}
