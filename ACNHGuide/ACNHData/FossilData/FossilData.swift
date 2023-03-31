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
    let imageURI: String
    let partOf: String

    private enum CodingKeys: String, CodingKey {
        case fileName = "file-name"
        case name, price
        case museumPhrase = "museum-phrase"
        case imageURI = "image_uri"
        case partOf = "part-of"
    }
}

extension FossilData: Equatable {
    static func == (lhs: FossilData, rhs: FossilData) -> Bool {
        lhs.fileName == rhs.fileName
    }
}
