//
//  FossilData.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation

struct FossilData: Decodable {
    let fileName: String
    let name: Name
    let price: Int
    let museumPhrase: String
    // Conservée telle quelle dans le JSON, mais elle pointe vers acnhapi.com,
    // hors ligne : utiliser imageURL pour afficher un visuel.
    let legacyImageURI: String
    let partOf: String

    private enum CodingKeys: String, CodingKey {
        case fileName = "file-name"
        case name, price
        case museumPhrase = "museum-phrase"
        case legacyImageURI = "image_uri"
        case partOf = "part-of"
    }
}

extension FossilData {
    // Les fossiles n'ont pas d'icône dédiée dans le miroir, seulement un visuel.
    var imageURL: URL? {
        ACNHAPI.imageURL(for: .fossils, fileName: fileName)
    }
}

extension FossilData: Equatable {
    static func == (lhs: FossilData, rhs: FossilData) -> Bool {
        lhs.fileName == rhs.fileName
    }
}
