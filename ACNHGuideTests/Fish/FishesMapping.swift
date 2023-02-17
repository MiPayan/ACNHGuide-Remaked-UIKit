//
//  FishesMapping.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 18/01/2023.
//

import XCTest
@testable import ACNHGuide

final class FishesMapping: XCTestCase {
    
    func testFishesJsonMapping() throws {
        guard let id = fishes.first?.id,
              let filename = fishes.first?.fileName,
              let nameUSen = fishes.first?.name.nameUSen,
              let nameEUen = fishes.first?.name.nameEUen,
              let nameEUde = fishes.first?.name.nameEUde,
              let nameEUes = fishes.first?.name.nameEUes,
              let nameUSes = fishes.first?.name.nameUSes,
              let nameEUfr = fishes.first?.name.nameEUfr,
              let nameUSfr = fishes.first?.name.nameUSfr,
              let nameEUit = fishes.first?.name.nameEUit,
              let nameEUnl = fishes.first?.name.nameEUnl,
              let nameCNzh = fishes.first?.name.nameCNzh,
              let nameTWzh = fishes.first?.name.nameTWzh,
              let nameJPja = fishes.first?.name.nameJPja,
              let nameKRko = fishes.first?.name.nameKRko,
              let nameEUru = fishes.first?.name.nameEUru,
              let monthNorthern = fishes.first?.availability.monthNorthern,
              let monthSouthern = fishes.first?.availability.monthSouthern,
              let time = fishes.first?.availability.time,
              let isAllDay = fishes.first?.availability.isAllDay,
              let isAllYear = fishes.first?.availability.isAllYear,
              let location = fishes.first?.availability.location,
              let rarity = fishes.first?.availability.rarity,
              let monthArrayNorthern = fishes.first?.availability.monthArrayNorthern,
              let monthArraySouthern = fishes.first?.availability.monthArraySouthern,
              let timeArray = fishes.first?.availability.timeArray,
              let shadow = fishes.first?.shadow,
              let price = fishes.first?.price,
              let priceCj = fishes.first?.priceCj,
              let catchPhrase = fishes.first?.catchPhrase,
              let museumPhrase = fishes.first?.museumPhrase,
              let imageURI = fishes.first?.imageURI,
              let iconURI = fishes.first?.iconURI else {
            fatalError("Tests failed: testFishesJsonMapping() from FishesMapping")
        }
        XCTAssertEqual(id, 1)
        XCTAssertEqual(filename, "bitterling")
        XCTAssertEqual(nameUSen, "bitterling")
        XCTAssertEqual(nameEUen, "bitterling")
        XCTAssertEqual(nameEUde, "Bitterling")
        XCTAssertEqual(nameEUes, "amarguillo")
        XCTAssertEqual(nameUSes, "amarguillo")
        XCTAssertEqual(nameEUfr, "bouvière")
        XCTAssertEqual(nameUSfr, "bouvière")
        XCTAssertEqual(nameEUit, "rodeo")
        XCTAssertEqual(nameEUnl, "bittervoorn")
        XCTAssertEqual(nameCNzh, "红目鲫")
        XCTAssertEqual(nameTWzh, "紅目鯽")
        XCTAssertEqual(nameJPja, "タナゴ")
        XCTAssertEqual(nameKRko, "납줄개")
        XCTAssertEqual(nameEUru, "горчак")
        XCTAssertEqual(monthNorthern, "11-3")
        XCTAssertEqual(monthSouthern, "5-9")
        XCTAssertEqual(time, "")
        XCTAssertEqual(isAllDay, true)
        XCTAssertEqual(isAllYear, false)
        XCTAssertEqual(location, "River")
        XCTAssertEqual(rarity, "Common")
        XCTAssertEqual(monthArrayNorthern, [
            11,
            12,
            1,
            2,
            3
        ])
        XCTAssertEqual(monthArraySouthern, [
            5,
            6,
            7,
            8,
            9
        ])
        XCTAssertEqual(timeArray, [
            0,
            1,
            2,
            3,
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
            18,
            19,
            20,
            21,
            22,
            23
        ])
        XCTAssertEqual(shadow, "Smallest (1)")
        XCTAssertEqual(price, 900)
        XCTAssertEqual(priceCj, 1350)
        XCTAssertEqual(catchPhrase, "I caught a bitterling! It's mad at me, but only a little.")
        XCTAssertEqual(museumPhrase, "Bitterlings hide their eggs inside large bivalves—like clams—where the young can stay safe until grown. The bitterling isn't being sneaky. No, their young help keep the bivalve healthy by eating invading parasites! It's a wonderful bit of evolutionary deal making, don't you think? Each one keeping the other safe... Though eating parasites does not sound like a happy childhood... Is that why the fish is so bitter?")
        XCTAssertEqual(imageURI, "https://acnhapi.com/v1/images/fish/1")
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/fish/1")
    }
}
