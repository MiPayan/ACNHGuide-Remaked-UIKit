//
//  Name.swift
//  ACNHS
//
//  Created by Mickael PAYAN on 03/05/2022.
//

import Foundation

struct Name: Decodable {
    let nameUSen, nameEUen, nameEUde, nameEUes: String
    let nameUSes, nameEUfr, nameUSfr, nameEUit: String
    let nameEUnl, nameCNzh, nameTWzh, nameJPja: String
    let nameKRko, nameEUru: String

    enum CodingKeys: String, CodingKey {
        case nameUSen = "name-USen"
        case nameEUen = "name-EUen"
        case nameEUde = "name-EUde"
        case nameEUes = "name-EUes"
        case nameUSes = "name-USes"
        case nameEUfr = "name-EUfr"
        case nameUSfr = "name-USfr"
        case nameEUit = "name-EUit"
        case nameEUnl = "name-EUnl"
        case nameCNzh = "name-CNzh"
        case nameTWzh = "name-TWzh"
        case nameJPja = "name-JPja"
        case nameKRko = "name-KRko"
        case nameEUru = "name-EUru"
    }
}
