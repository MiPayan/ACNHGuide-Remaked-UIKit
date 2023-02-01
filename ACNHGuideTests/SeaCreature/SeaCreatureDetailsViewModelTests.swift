//
//  SeaCreatureDetailsViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 01/02/2023.
//

import XCTest
@testable import ACNHGuide

final class SeaCreatureDetailsViewModelTests: XCTestCase {
    
    private var seaCreatureDetailsViewModel: SeaCreatureDetailsViewModel!
    
    override func setUpWithError() throws {
        seaCreatureDetailsViewModel = SeaCreatureDetailsViewModel(seaCreatureData: seaCreatures[0])
    }
    
    override func tearDownWithError() throws {
        seaCreatureDetailsViewModel = nil
    }
    
    func testFileName() {
        guard let fileName = seaCreatures.first?.fileName else { return }
        let formatFileName = fileName.replaceCharacter("_", by: "").capitalized
        XCTAssertEqual(fileName, "seaweed")
        XCTAssertEqual(seaCreatureDetailsViewModel.fileName, formatFileName)
    }
    
    func testIconUri() {
        guard let iconURI = seaCreatures.first?.iconURI,
              let url = URL(string: iconURI) else { return }
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/sea/1")
        XCTAssertEqual(seaCreatureDetailsViewModel.iconURL, url)
    }
    
    func testCatchPhrase() {
        guard let catchPhrase = seaCreatures.first?.catchPhrase else { return }
        XCTAssertEqual(catchPhrase, "I got some seaweed! I couldn't kelp myself.")
        XCTAssertEqual(seaCreatureDetailsViewModel.catchPhrase, "\" \(catchPhrase) \"")
    }
    
    func testPrice() {
        guard let price = seaCreatures.first?.price else { return }
        XCTAssertEqual(price, 600)
        XCTAssertEqual(seaCreatureDetailsViewModel.price, String(price))
    }
    
    func testShadow() {
        guard let shadow = seaCreatures.first?.shadow else { return }
        XCTAssertEqual(shadow, "Large")
        XCTAssertEqual(seaCreatureDetailsViewModel.shadow, shadow)
    }
 
    func testAvailabilityTime() {
        guard let time = seaCreatures.first?.availability.time else { return }
        XCTAssertEqual(time, "")
        
        let availabilityTime = time.isEmpty ? "Always" : seaCreatureDetailsViewModel.availabilityTime
        
        XCTAssertEqual(availabilityTime, "Always")
        XCTAssertEqual(seaCreatureDetailsViewModel.availabilityTime, availabilityTime)
    }
    
    func testSpeed() {
        guard let speed = seaCreatures.first?.speed else { return }
        XCTAssertEqual(speed, "Stationary")
        XCTAssertEqual(seaCreatureDetailsViewModel.speed, speed)
    }
    
    func testNorthernHemisphereAvailability() {
        guard let monthNorthern = seaCreatures.first?.availability.monthNorthern else { return }
        XCTAssertEqual(monthNorthern, "10-7")
        XCTAssertEqual(seaCreatureDetailsViewModel.northernHemisphereAvailability, monthNorthern)
    }
    
    func testSouthernHemisphereAvailability() {
        guard let monthSouthern = seaCreatures.first?.availability.monthSouthern else { return }
        XCTAssertEqual(monthSouthern, "4-1")
        XCTAssertEqual(seaCreatureDetailsViewModel.southernHemisphereAvailability, monthSouthern)
    }
    
    func testMuseumPhrase() {
        guard let museumPhrase = seaCreatures.first?.museumPhrase else { return }
        XCTAssertEqual(museumPhrase, "Let it be known that seaweed is a misnomer of the highest order! That is, it is not a noxious weed so much as it is a marine algae most beneficial to life on land and sea. Seaweed, you see, provides essential habitat and food for all manner of marine creatures. And it creates a great deal of the oxygen we land lovers love to breath too, hoo! And yet, I can't help but shudder when the slimy stuff touches my toes during a swim. Hoot! The horror!")
        XCTAssertEqual(seaCreatureDetailsViewModel.museumPhrase, museumPhrase)
    }
    
    func testMakeImageName() {
        for index in 0...5 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(seaCreatureDetailsViewModel.makeImageName(at: index), "Bells")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(seaCreatureDetailsViewModel.makeImageName(at: index), "SeaCreatureShadow")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(seaCreatureDetailsViewModel.makeImageName(at: index), "Timer")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(seaCreatureDetailsViewModel.makeImageName(at: index), "Speedmeter")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(seaCreatureDetailsViewModel.makeImageName(at: index), "North")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(seaCreatureDetailsViewModel.makeImageName(at: index), "South")
            default:
                break
            }
        }
    }
    
    func testMakeTitle() {
        for index in 0...5 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(seaCreatureDetailsViewModel.makeTitle(at: index), "Price")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(seaCreatureDetailsViewModel.makeTitle(at: index), "Shadow")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(seaCreatureDetailsViewModel.makeTitle(at: index), "Time")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(seaCreatureDetailsViewModel.makeTitle(at: index), "Speed")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(seaCreatureDetailsViewModel.makeTitle(at: index), "Northern hemisphere")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(seaCreatureDetailsViewModel.makeTitle(at: index), "Southern hemisphere")
            default:
                break
            }
        }
    }
    
    func testMakeValue() {
        guard let price = seaCreatures.first?.price,
              let shadow = seaCreatures.first?.shadow,
              let time = seaCreatures.first?.availability.time,
              let speed = seaCreatures.first?.speed,
              let northernHemisphere = seaCreatures.first?.availability.monthNorthern,
              let southernHemisphere = seaCreatures.first?.availability.monthSouthern else { return }
        
        for index in 0...6 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(price, 600)
                XCTAssertEqual(seaCreatureDetailsViewModel.makeValue(at: index), String(price))
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(shadow, "Large")
                XCTAssertEqual(seaCreatureDetailsViewModel.makeValue(at: index), shadow)
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(time, "")
                
                let availabilityTime = time.isEmpty ? "Always" : seaCreatureDetailsViewModel.availabilityTime
                XCTAssertEqual(availabilityTime, "Always")
                XCTAssertEqual(seaCreatureDetailsViewModel.makeValue(at: index), availabilityTime)
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(speed, "Stationary")
                XCTAssertEqual(seaCreatureDetailsViewModel.makeValue(at: index), speed)
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(northernHemisphere, "10-7")
                XCTAssertEqual(seaCreatureDetailsViewModel.makeValue(at: index), northernHemisphere)
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(southernHemisphere, "4-1")
                XCTAssertEqual(seaCreatureDetailsViewModel.makeValue(at: index), southernHemisphere)
            default:
                break
            }
        }
    }
}
