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
    let imageURI, iconURI: String
    let museumPhrase: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case fileName = "file-name"
        case name, availability, speed, shadow, price
        case catchPhrase = "catch-phrase"
        case imageURI = "image_uri"
        case iconURI = "icon_uri"
        case museumPhrase = "museum-phrase"
    }
}

extension SeaCreatureData: Equatable {
    static func == (lhs: SeaCreatureData, rhs: SeaCreatureData) -> Bool {
        lhs.fileName == rhs.fileName
    }
}
