//
//  SeaCreaturesDetailsTableViewCellViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 31/01/2023.
//

import Foundation

final class SeaCreaturesDetailsTableViewCellViewModel {
    
    private let seaCreatureData: SeaCreatureData
    private let creaturePeeker: CreaturePeeking
    private let creatureWriter: CreatureWriting
    let numberOfItemsInSection = 6
    
    init(
        seaCreatureData: SeaCreatureData,
        creaturePeeker: CreaturePeeking = SeaCreatureService(),
        creatureWriter: CreatureWriting = SeaCreatureService()
    ) {
        self.seaCreatureData = seaCreatureData
        self.creaturePeeker = creaturePeeker
        self.creatureWriter = creatureWriter
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
        [
            price,
            shadow,
            availabilityTime,
            speed,
            northernHemisphereAvailability,
            southernHemisphereAvailability
        ][index]
    }
}

private extension SeaCreaturesDetailsTableViewCellViewModel {
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
}

extension SeaCreaturesDetailsTableViewCellViewModel {
    var isSeaCreatureAlreadySaved: Bool {
        creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
    }
    
    func toggleSavedSeaCreature() -> Bool {
        let isSaved = creaturePeeker.isCreatureAlreadySaved(fileName: fileName)
        if isSaved {
            creatureWriter.deleteCreature(fileName: fileName)
        } else {
            creatureWriter.saveCreature(fileName: fileName)
        }
        return !isSaved
    }
}
