//
//  FossilData.swift
//  ACNHS
//
//  Created by Mickael PAYAN on 03/05/2022.
//

import Foundation

struct FossilData: Decodable {
    let fileName: String
    let name: Name
    let price: Int
    let museumPhrase: String
    let imageURI: String
    let partOf: String

    enum CodingKeys: String, CodingKey {
        case fileName = "file-name"
        case name, price
        case museumPhrase = "museum-phrase"
        case imageURI = "image_uri"
        case partOf = "part-of"
    }
}
