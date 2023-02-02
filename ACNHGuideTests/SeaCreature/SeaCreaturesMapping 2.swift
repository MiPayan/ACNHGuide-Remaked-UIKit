//
//  SeaCreaturesMapping.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

import XCTest
@testable import ACNHGuide

final class SeaCreaturesMapping: XCTestCase {

    func testSeaCreatureJsonMapping() throws {
            guard let id = seaCreatures.first?.id,
                  let filename = seaCreatures.first?.fileName,
                  let nameUSen = seaCreatures.first?.name.nameUSen,
                  let nameEUen = seaCreatures.first?.name.nameEUen,
                  let nameEUde = seaCreatures.first?.name.nameEUde,
                  let nameEUes = seaCreatures.first?.name.nameEUes,
                  let nameUSes = seaCreatures.first?.name.nameUSes,
                  let nameEUfr = seaCreatures.first?.name.nameEUfr,
                  let nameUSfr = seaCreatures.first?.name.nameUSfr,
                  let nameEUit = seaCreatures.first?.name.nameEUit,
                  let nameEUnl = seaCreatures.first?.name.nameEUnl,
                  let nameCNzh = seaCreatures.first?.name.nameCNzh,
                  let nameTWzh = seaCreatures.first?.name.nameTWzh,
                  let nameJPja = seaCreatures.first?.name.nameJPja,
                  let nameKRko = seaCreatures.first?.name.nameKRko,
                  let nameEUru = seaCreatures.first?.name.nameEUru,
                  let monthNorthern = seaCreatures.first?.availability.monthNorthern,
                  let monthSouthern = seaCreatures.first?.availability.monthSouthern,
                  let time = seaCreatures.first?.availability.time,
                  let isAllDay = seaCreatures.first?.availability.isAllDay,
                  let isAllYear = seaCreatures.first?.availability.isAllYear,
                  let monthArrayNorthern = seaCreatures.first?.availability.monthArrayNorthern,
                  let monthArraySouthern = seaCreatures.first?.availability.monthArraySouthern,
                  let timeArray = seaCreatures.first?.availability.timeArray,
                  let speed = seaCreatures.first?.speed,
                  let shadow = seaCreatures.first?.shadow,
                  let price = seaCreatures.first?.price,
                  let catchPhrase = seaCreatures.first?.catchPhrase,
                  let museumPhrase = seaCreatures.first?.museumPhrase,
                  let imageURI = seaCreatures.first?.imageURI,
                  let iconURI = seaCreatures.first?.iconURI else {
                return
            }
            XCTAssertEqual(id, 1)
            XCTAssertEqual(filename, "seaweed")
            XCTAssertEqual(nameUSen, "seaweed")
            XCTAssertEqual(nameEUen, "seaweed")
            XCTAssertEqual(nameEUnl, "zeewier")
            XCTAssertEqual(nameEUde, "Wakame-Alge")
            XCTAssertEqual(nameEUes, "alga wakame")
            XCTAssertEqual(nameUSes, "alga wakame")
            XCTAssertEqual(nameEUfr, "wakame")
            XCTAssertEqual(nameUSfr, "wakamé")
            XCTAssertEqual(nameEUit, "alga wakame")
            XCTAssertEqual(nameCNzh, "裙带菜")
            XCTAssertEqual(nameTWzh, "裙帶菜")
            XCTAssertEqual(nameJPja, "ワカメ")
            XCTAssertEqual(nameKRko, "미역")
            XCTAssertEqual(nameEUru, "морские водоросли")
            XCTAssertEqual(monthNorthern, "10-7")
            XCTAssertEqual(monthSouthern, "4-1")
            XCTAssertEqual(time, "")
            XCTAssertEqual(isAllDay, true)
            XCTAssertEqual(isAllYear, false)
            XCTAssertEqual(monthArrayNorthern, [
                10,
                11,
                12,
                1,
                2,
                3,
                4,
                5,
                6,
                7
             ])
            XCTAssertEqual(monthArraySouthern, [
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                1
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
            XCTAssertEqual(speed, "Stationary")
            XCTAssertEqual(shadow, "Large")
            XCTAssertEqual(price, 600)
            XCTAssertEqual(catchPhrase, "I got some seaweed! I couldn't kelp myself.")
            XCTAssertEqual(imageURI, "https://acnhapi.com/v1/images/sea/1")
            XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/sea/1")
            XCTAssertEqual(museumPhrase, "Let it be known that seaweed is a misnomer of the highest order! That is, it is not a noxious weed so much as it is a marine algae most beneficial to life on land and sea. Seaweed, you see, provides essential habitat and food for all manner of marine creatures. And it creates a great deal of the oxygen we land lovers love to breath too, hoo! And yet, I can't help but shudder when the slimy stuff touches my toes during a swim. Hoot! The horror!")
        }
}
