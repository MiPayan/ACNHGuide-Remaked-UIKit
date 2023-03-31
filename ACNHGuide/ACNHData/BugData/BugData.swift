//
//  BugData.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation

struct BugData: Decodable {
    let id: Int
    let fileName: String
    let name: Name
    let availability: BugAvailability
    let price, priceFlick: Int
    let catchPhrase, museumPhrase: String
    let imageURI, iconURI: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case fileName = "file-name"
        case name, availability, price
        case priceFlick = "price-flick"
        case catchPhrase = "catch-phrase"
        case museumPhrase = "museum-phrase"
        case imageURI = "image_uri"
        case iconURI = "icon_uri"
    }
}

extension BugData: Equatable {
    static func == (lhs: BugData, rhs: BugData) -> Bool {
        lhs.fileName == rhs.fileName
    }
}
