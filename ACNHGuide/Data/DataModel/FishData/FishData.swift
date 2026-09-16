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
    // Conservées telles quelles dans le JSON, mais elles pointent vers acnhapi.com,
    // hors ligne : utiliser imageURL et iconURL pour afficher un visuel.
    let legacyImageURI, legacyIconURI: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case fileName = "file-name"
        case name, availability, shadow, price
        case priceCj = "price-cj"
        case catchPhrase = "catch-phrase"
        case museumPhrase = "museum-phrase"
        case legacyImageURI = "image_uri"
        case legacyIconURI = "icon_uri"
    }
}

extension FishData {
    var imageURL: URL? {
        ACNHAPI.imageURL(for: .fish, fileName: fileName)
    }
    
    var iconURL: URL? {
        ACNHAPI.iconURL(for: .fish, fileName: fileName)
    }
}

extension FishData: Equatable {
    static func == (lhs: FishData, rhs: FishData) -> Bool {
        lhs.fileName == rhs.fileName
    }
}
