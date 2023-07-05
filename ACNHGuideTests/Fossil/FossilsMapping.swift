//
//  FossilsMapping.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

import XCTest
@testable import ACNHGuide

final class FossilsMapping: XCTestCase {
    
    func testFossilJsonMapping() throws {
        let filename = fossils.first?.fileName
        let nameUSen = fossils.first?.name.nameUSen
        let nameEUen = fossils.first?.name.nameEUen
        let nameEUde = fossils.first?.name.nameEUde
        let nameEUes = fossils.first?.name.nameEUes
        let nameUSes = fossils.first?.name.nameUSes
        let nameEUfr = fossils.first?.name.nameEUfr
        let nameUSfr = fossils.first?.name.nameUSfr
        let nameEUit = fossils.first?.name.nameEUit
        let nameEUnl = fossils.first?.name.nameEUnl
        let nameCNzh = fossils.first?.name.nameCNzh
        let nameTWzh = fossils.first?.name.nameTWzh
        let nameJPja = fossils.first?.name.nameJPja
        let nameKRko = fossils.first?.name.nameKRko
        let nameEUru = fossils.first?.name.nameEUru
        let price = fossils.first?.price
        let museumPhrase = fossils.first?.museumPhrase
        let imageURI = fossils.first?.imageURI
        let partOf = fossils.first?.partOf
        XCTAssertEqual(filename, "acanthostega")
        XCTAssertEqual(nameUSen, "acanthostega")
        XCTAssertEqual(nameEUen, "acanthostega")
        XCTAssertEqual(nameEUde, "Acanthostega")
        XCTAssertEqual(nameEUes, "acantostega")
        XCTAssertEqual(nameUSes, "acantostega")
        XCTAssertEqual(nameEUfr, "acanthostéga")
        XCTAssertEqual(nameUSfr, "acanthostéga")
        XCTAssertEqual(nameEUit, "acantostega")
        XCTAssertEqual(nameEUnl, "acanthostega")
        XCTAssertEqual(nameCNzh, "棘螈")
        XCTAssertEqual(nameTWzh, "棘螈")
        XCTAssertEqual(nameJPja, "アカントステガ")
        XCTAssertEqual(nameKRko, "아칸토스테가")
        XCTAssertEqual(nameEUru, "акантостега")
        XCTAssertEqual(price, 2000)
        XCTAssertEqual(museumPhrase, "The acanthostega! Said to be one of the earliest amphibians, it existed well before dinosaurs. Because they lived as fish not long before, they still had gills and very webbed \"hands.\". To toss away the life they knew and venture onto unknown lands... they must have been very brave! Hmm... Does it still count as bravery if you have no understanding of what you're doing?")
        XCTAssertEqual(imageURI, "https://acnhapi.com/v1/images/fossils/acanthostega")
        XCTAssertEqual(partOf, "acanthostega")
    }
}
