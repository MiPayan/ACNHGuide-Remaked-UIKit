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
    // Conservées telles quelles dans le JSON, mais elles pointent vers acnhapi.com,
    // hors ligne : utiliser imageURL et iconURL pour afficher un visuel.
    let legacyImageURI, legacyIconURI: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case fileName = "file-name"
        case name, availability, price
        case priceFlick = "price-flick"
        case catchPhrase = "catch-phrase"
        case museumPhrase = "museum-phrase"
        case legacyImageURI = "image_uri"
        case legacyIconURI = "icon_uri"
    }
}

extension BugData {
    var imageURL: URL? {
        ACNHAPI.imageURL(for: .bugs, fileName: fileName)
    }
    
    var iconURL: URL? {
        ACNHAPI.iconURL(for: .bugs, fileName: fileName)
    }
}

extension BugData: Equatable {
    static func == (lhs: BugData, rhs: BugData) -> Bool {
        lhs.fileName == rhs.fileName
    }
}
