//
//  FishData.swift
//  ACNHS
//
//  Created by Mickael PAYAN on 03/05/2022.
//

import Foundation

struct FishData: Decodable {
    let id: Int
    let fileName: String
    let name: Name
    let availability: FishAvailability
    let shadow: String
    let price, priceCj: Int
    let catchPhrase, museumPhrase: String
    let imageURI, iconURI: String

    enum CodingKeys: String, CodingKey {
        case id
        case fileName = "file-name"
        case name, availability, shadow, price
        case priceCj = "price-cj"
        case catchPhrase = "catch-phrase"
        case museumPhrase = "museum-phrase"
        case imageURI = "image_uri"
        case iconURI = "icon_uri"
    }
}
