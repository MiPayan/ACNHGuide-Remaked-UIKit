//
//  BugsData.swift
//  ACNHS
//
//  Created by Mickael PAYAN on 03/05/2022.
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

    enum CodingKeys: String, CodingKey {
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
