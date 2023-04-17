//
//  FishDetailsTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 27/01/2023.
//

import Foundation

final class FishDetailsTableViewCellViewModel {
    
    private let fishData: FishData
    private let creaturePeeker: CreaturePeeking
    private let creatureWriter: CreatureWriting
    let numberOfItemsInSection = 8
    var errorCreatureDatabase: ((String) -> Void) = {_ in}
    
    init(
        fishData: FishData,
        creaturePeeker: CreaturePeeking = FishService(),
        creatureWriter: CreatureWriting = FishService()
    ) {
        self.fishData = fishData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
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
    
    var museumPhrase: String {
        fishData.museumPhrase
    }
    
    func makeImageName(at index: Int) -> String {
        ["Bells", "CJ", "FishingRod", "FishShadow", "Timer", "Rarity", "North", "South"][index]
    }
    
    func makeTitle(at index: Int) -> String {
        [
            "price".localized,
            "price_cj".localized,
            "location".localized,
            "shadow".localized,
            "time".localized,
            "rarity".localized,
            "northern_hemisphere".localized,
            "southern_hemisphere".localized
        ][index]
    }
    
    func makeValue(at index: Int) -> String {
        [
            price,
            priceCJ,
            availabilityLocation,
            shadow,
            availabilityTime,
            rarity,
            northernHemisphereAvailability,
            southernHemisphereAvailability
        ][index]
    }
}

private extension FishDetailsTableViewCellViewModel {
    var price: String {
        String(fishData.price)
    }
    
    var priceCJ: String {
        String(fishData.priceCj)
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
}

extension FishDetailsTableViewCellViewModel {
    var isFishAlreadySaved: Bool {
        creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func toggleSavedFish() -> Bool {
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
