//
//  FishDetailsTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 27/01/2023.
//

import Foundation

final class FishDetailsTableViewCellViewModel {
    
    private let fishData: FishData
    let numberOfItemsInSection = 7
    
    init(fishData: FishData) {
        self.fishData = fishData
    }
    
    var fileName: String {
        fishData.fileName.replaceCharacter("_", by: " ").capitalized
    }
        
    var iconURL: URL? {
        guard let iconURL = URL(string: fishData.iconURI) else { return nil }
        return iconURL
    }
        
    var catchPhrase: String {
        "\" \(fishData.catchPhrase) \""
    }
    
    var price: String {
        String(fishData.price)
    }
    
    var availabilityLocation: String {
        fishData.availability.location.replaceCharacter("when ", by: "")
    }
    
    var shadow: String {
        fishData.shadow
    }
    
    var availabilityTime: String {
        fishData.availability.time.isEmpty ? "availibility_always".localized : fishData.availability.time
    }
    
    var rarity: String {
        String(fishData.availability.rarity)
    }
    
    var northernHemisphereAvailability: String {
        fishData.availability.monthNorthern.isEmpty ? "availibility_always".localized : fishData.availability.monthNorthern
    }
    
    var southernHemisphereAvailability: String {
        fishData.availability.monthSouthern.isEmpty ? "availibility_always".localized : fishData.availability.monthSouthern
    }
    
    var museumPhrase: String {
        fishData.museumPhrase
    }
    
    func makeImageName(at index: Int) -> String {
        ["Bells", "FishingRod", "FishShadow", "Timer", "Rarity", "North", "South"][index]
    }
    
    func makeTitle(at index: Int) -> String {
        [
            "price".localized,
            "location".localized,
            "shadow".localized,
            "time".localized,
            "rarity".localized,
            "northern_hemisphere".localized,
            "southern_hemisphere".localized
        ][index]
    }
    
    func makeValue(at index: Int) -> String {
        [price, availabilityLocation, shadow, availabilityTime, rarity, northernHemisphereAvailability, southernHemisphereAvailability][index]
    }
}
