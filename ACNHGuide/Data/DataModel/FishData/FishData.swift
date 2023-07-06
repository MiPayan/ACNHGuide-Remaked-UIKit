//
//  FishData.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
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
    
    private enum CodingKeys: String, CodingKey {
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

extension FishData: Equatable {
    static func == (lhs: FishData, rhs: FishData) -> Bool {
        lhs.fileName == rhs.fileName
    }
}
