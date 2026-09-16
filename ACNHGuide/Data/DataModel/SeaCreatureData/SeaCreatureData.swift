//
//  SeaCreatureData.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation

struct SeaCreatureData: Decodable {
    let id: Int
    let fileName: String
    let name: Name
    let availability: SeaAvailability
    let speed, shadow: String
    let price: Int
    let catchPhrase: String
    // Conservées telles quelles dans le JSON, mais elles pointent vers acnhapi.com,
    // hors ligne : utiliser imageURL et iconURL pour afficher un visuel.
    let legacyImageURI, legacyIconURI: String
    let museumPhrase: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case fileName = "file-name"
        case name, availability, speed, shadow, price
        case catchPhrase = "catch-phrase"
        case legacyImageURI = "image_uri"
        case legacyIconURI = "icon_uri"
        case museumPhrase = "museum-phrase"
    }
}

extension SeaCreatureData {
    var imageURL: URL? {
        ACNHAPI.imageURL(for: .sea, fileName: fileName)
    }
    
    var iconURL: URL? {
        ACNHAPI.iconURL(for: .sea, fileName: fileName)
    }
}

extension SeaCreatureData: Equatable {
    static func == (lhs: SeaCreatureData, rhs: SeaCreatureData) -> Bool {
        lhs.fileName == rhs.fileName
    }
}
