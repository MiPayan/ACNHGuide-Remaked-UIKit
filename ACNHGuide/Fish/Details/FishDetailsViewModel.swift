//
//  FishDetailsViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 27/01/2023.
//

import Foundation

final class FishDetailsViewModel {
    
    private let fishData: FishData
    
    init(fishData: FishData) {
        self.fishData = fishData
    }
        
    var iconURL: URL? {
        guard let iconURL = URL(string: fishData.iconURI) else { return nil }
        return iconURL
    }
    
    var museumPhrase: String {
        fishData.museumPhrase
    }
    
    var fileName: String {
        fishData.fileName.replaceCharacter("_", by: "").capitalized
    }
    
    var catchPhrase: String {
        "\" \(fishData.catchPhrase) \""
    }
    
    private var price: String {
        String(fishData.price)
    }
    
    private var availabilityLocation: String {
        fishData.availability.location.replaceCharacter("when ", by: "")
    }
    
    private var shadow: String {
        fishData.shadow
    }
    
    private var availabilityTime: String {
        fishData.availability.time.isEmpty ? "Always" : fishData.availability.time
    }
    
    private var rarity: String {
        String(fishData.availability.rarity)
    }
    
    private var northernHemisphereAvailability: String {
        fishData.availability.monthNorthern.isEmpty ? "Always" : fishData.availability.monthNorthern
    }
    
    private var southernHemisphereAvailability: String {
        fishData.availability.monthSouthern.isEmpty ? "Always" : fishData.availability.monthSouthern
    }
    
    func makeImageName(at index: Int) -> String {
        ["Bells", "FishingRod", "FishShadow", "Timer", "Rarity", "North", "South"][index]
    }
    
    func makeTitle(at index: Int) -> String {
        ["Price", "Location", "Shadow", "Time", "Rarity", "Northern hemisphere", "Southern hemisphere"][index]
    }
    
    func makeValue(at index: Int) -> String {
        [price, availabilityLocation, shadow, availabilityTime, rarity, northernHemisphereAvailability, southernHemisphereAvailability][index]
    }
}
