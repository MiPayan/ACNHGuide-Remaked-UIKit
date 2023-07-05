//
//  BugsMapping.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

import XCTest
@testable import ACNHGuide

final class BugsMapping: XCTestCase {
    
    func testBugsJsonMapping() throws {
        let id = bugs.first?.id
        let filename = bugs.first?.fileName
        let nameUSen = bugs.first?.name.nameUSen
        let nameEUen = bugs.first?.name.nameEUen
        let nameEUde = bugs.first?.name.nameEUde
        let nameEUes = bugs.first?.name.nameEUes
        let nameUSes = bugs.first?.name.nameUSes
        let nameEUfr = bugs.first?.name.nameEUfr
        let nameUSfr = bugs.first?.name.nameUSfr
        let nameEUit = bugs.first?.name.nameEUit
        let nameEUnl = bugs.first?.name.nameEUnl
        let nameCNzh = bugs.first?.name.nameCNzh
        let nameTWzh = bugs.first?.name.nameTWzh
        let nameJPja = bugs.first?.name.nameJPja
        let nameKRko = bugs.first?.name.nameKRko
        let nameEUru = bugs.first?.name.nameEUru
        let monthNorthern = bugs.first?.availability.monthNorthern
        let monthSouthern = bugs.first?.availability.monthSouthern
        let time = bugs.first?.availability.time
        let isAllDay = bugs.first?.availability.isAllDay
        let isAllYear = bugs.first?.availability.isAllYear
        let location = bugs.first?.availability.location
        let rarity = bugs.first?.availability.rarity
        let monthArrayNorthern = bugs.first?.availability.monthArrayNorthern
        let monthArraySouthern = bugs.first?.availability.monthArraySouthern
        let timeArray = bugs.first?.availability.timeArray
        let price = bugs.first?.price
        let priceFlick = bugs.first?.priceFlick
        let catchPhrase = bugs.first?.catchPhrase
        let museumPhrase = bugs.first?.museumPhrase
        let imageURI = bugs.first?.imageURI
        let iconURI = bugs.first?.iconURI
        XCTAssertEqual(id, 1)
        XCTAssertEqual(filename, "common_butterfly")
        XCTAssertEqual(nameUSen, "common butterfly")
        XCTAssertEqual(nameEUen, "common butterfly")
        XCTAssertEqual(nameEUde, "Kohlweißling")
        XCTAssertEqual(nameEUes, "mariposa común")
        XCTAssertEqual(nameUSes, "mariposa común")
        XCTAssertEqual(nameEUfr, "piéride de la rave")
        XCTAssertEqual(nameUSfr, "piéride de la rave")
        XCTAssertEqual(nameEUit, "farfalla comune")
        XCTAssertEqual(nameEUnl, "koolwitje")
        XCTAssertEqual(nameCNzh, "白粉蝶")
        XCTAssertEqual(nameTWzh, "白粉蝶")
        XCTAssertEqual(nameJPja, "モンシロチョウ")
        XCTAssertEqual(nameKRko, "배추흰나비")
        XCTAssertEqual(nameEUru, "белянка")
        XCTAssertEqual(monthNorthern, "9-6")
        XCTAssertEqual(monthSouthern, "3-12")
        XCTAssertEqual(time, "4am - 7pm")
        XCTAssertEqual(isAllDay, false)
        XCTAssertEqual(isAllYear, false)
        XCTAssertEqual(location, "Flying")
        XCTAssertEqual(rarity, "Common")
        XCTAssertEqual(monthArrayNorthern, [
            9,
            10,
            11,
            12,
            1,
            2,
            3,
            4,
            5,
            6
        ])
        XCTAssertEqual(monthArraySouthern, [
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12
        ])
        XCTAssertEqual(timeArray, [
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16,
            17,
            18
        ])
        XCTAssertEqual(price, 160)
        XCTAssertEqual(priceFlick, 240)
        XCTAssertEqual(catchPhrase, "I caught a common butterfly! They often flutter by!")
        XCTAssertEqual(museumPhrase, "The common butterfly would have you believe it is but a beautiful friend flitting prettily about the flowers. Bah, I say! They may seem innocent things with their pretty white wings, but they hide a dark side! The common butterfly caterpillar is called a cabbage worm, you see, and it's a most voracious pest. The ravenous beasts chew through cabbage, broccoli, kale and the like with a devastating gusto. And my feathers! Their green coloring is truly GROSS! A hoo-rrific hue, I say.")
        XCTAssertEqual(imageURI, "https://acnhapi.com/v1/images/bugs/1")
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/bugs/1")
    }
}
