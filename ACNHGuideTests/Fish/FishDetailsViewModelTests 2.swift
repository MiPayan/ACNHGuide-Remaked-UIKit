//
//  FishDetailsViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 01/02/2023.
//

import XCTest
@testable import ACNHGuide

final class FishDetailsViewModelTests: XCTestCase {
    
    private var fishDetailsViewModel: FishDetailsViewModel!
    
    override func setUpWithError() throws {
        fishDetailsViewModel = FishDetailsViewModel(fishData: fishes[0])
    }
    
    override func tearDownWithError() throws {
        fishDetailsViewModel = nil
    }
    
    func testFileName() {
        guard let fileName = fishes.first?.fileName else { return }
        let formatFileName = fileName.replaceCharacter("_", by: "").capitalized
        XCTAssertEqual(fileName, "bitterling")
        XCTAssertEqual(fishDetailsViewModel.fileName, formatFileName)
    }
    
    func testIconURL() {
        guard let iconURI = fishes.first?.iconURI,
              let url = URL(string: iconURI) else { return }
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/fish/1")
        XCTAssertEqual(fishDetailsViewModel.iconURL, url)
    }
    
    func testCatchPhrase() {
        guard let catchPhrase = fishes.first?.catchPhrase else { return }
        XCTAssertEqual(catchPhrase, "I caught a bitterling! It's mad at me, but only a little.")
        XCTAssertEqual(fishDetailsViewModel.catchPhrase, "\" \(catchPhrase) \"")
    }
    
    func testPrice() {
        guard let price = fishes.first?.price else { return }
        XCTAssertEqual(price, 900)
        XCTAssertEqual(fishDetailsViewModel.price, String(price))
    }
    
    func testAvailabilityLocation() {
        guard let location = fishes.first?.availability.location else { return }
        XCTAssertEqual(location, "River")
        XCTAssertEqual(fishDetailsViewModel.availabilityLocation, location)
    }
    
    func testShadow() {
        guard let shadow = fishes.first?.shadow else { return }
        XCTAssertEqual(shadow, "Smallest (1)")
        XCTAssertEqual(fishDetailsViewModel.shadow, shadow)
    }
 
    func testAvailabilityTime() {
        guard let time = fishes.first?.availability.time else { return }
        XCTAssertEqual(time, "")
        
        let availabilityTime = time.isEmpty ? "Always" : fishDetailsViewModel.availabilityTime
        XCTAssertEqual(availabilityTime, "Always")
        XCTAssertEqual(fishDetailsViewModel.availabilityTime, availabilityTime)
    }
    
    func testRarity() {
        guard let rarity = fishes.first?.availability.rarity else { return }
        XCTAssertEqual(rarity, "Common")
        XCTAssertEqual(fishDetailsViewModel.rarity, rarity)
    }
    
    func testNorthernHemisphereAvailability() {
        guard let monthNorthern = fishes.first?.availability.monthNorthern else { return }
        XCTAssertEqual(monthNorthern, "11-3")
        XCTAssertEqual(fishDetailsViewModel.northernHemisphereAvailability, monthNorthern)
    }
    
    func testSouthernHemisphereAvailability() {
        guard let monthSouthern = fishes.first?.availability.monthSouthern else { return }
        XCTAssertEqual(monthSouthern, "5-9")
        XCTAssertEqual(fishDetailsViewModel.southernHemisphereAvailability, monthSouthern)
    }
    
    func testMuseumPhrase() {
        guard let museumPhrase = fishes.first?.museumPhrase else { return }
        XCTAssertEqual(museumPhrase, "Bitterlings hide their eggs inside large bivalves—like clams—where the young can stay safe until grown. The bitterling isn't being sneaky. No, their young help keep the bivalve healthy by eating invading parasites! It's a wonderful bit of evolutionary deal making, don't you think? Each one keeping the other safe... Though eating parasites does not sound like a happy childhood... Is that why the fish is so bitter?")
        XCTAssertEqual(fishDetailsViewModel.museumPhrase, museumPhrase)
    }
    
    func testMakeImageName() {
        for index in 0...6 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(fishDetailsViewModel.makeImageName(at: index), "Bells")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(fishDetailsViewModel.makeImageName(at: index), "FishingRod")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(fishDetailsViewModel.makeImageName(at: index), "FishShadow")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(fishDetailsViewModel.makeImageName(at: index), "Timer")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(fishDetailsViewModel.makeImageName(at: index), "Rarity")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(fishDetailsViewModel.makeImageName(at: index), "North")
            case 6:
                XCTAssertEqual(index, 6)
                XCTAssertEqual(fishDetailsViewModel.makeImageName(at: index), "South")
            default:
                break
            }
        }
    }
    
    func testMakeTitle() {
        for index in 0...6 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(fishDetailsViewModel.makeTitle(at: index), "Price")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(fishDetailsViewModel.makeTitle(at: index), "Location")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(fishDetailsViewModel.makeTitle(at: index), "Shadow")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(fishDetailsViewModel.makeTitle(at: index), "Time")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(fishDetailsViewModel.makeTitle(at: index), "Rarity")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(fishDetailsViewModel.makeTitle(at: index), "Northern hemisphere")
            case 6:
                XCTAssertEqual(index, 6)
                XCTAssertEqual(fishDetailsViewModel.makeTitle(at: index), "Southern hemisphere")
            default:
                break
            }
        }
    }
    
    func testMakeValue() {
        guard let price = fishes.first?.price,
              let location = fishes.first?.availability.location,
              let shadow = fishes.first?.shadow,
              let time = fishes.first?.availability.time,
              let rarity = fishes.first?.availability.rarity,
              let northernHemisphere = fishes.first?.availability.monthNorthern,
              let southernHemisphere = fishes.first?.availability.monthSouthern else { return }
        
        for index in 0...6 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(price, 900)
                XCTAssertEqual(fishDetailsViewModel.makeValue(at: index), String(price))
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(location, "River")
                XCTAssertEqual(fishDetailsViewModel.makeValue(at: index), location)
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(shadow, "Smallest (1)")
                XCTAssertEqual(fishDetailsViewModel.makeValue(at: index), shadow)
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(time, "")
                
                let availabilityTime = time.isEmpty ? "Always" : fishDetailsViewModel.availabilityTime
                XCTAssertEqual(availabilityTime, "Always")
                XCTAssertEqual(fishDetailsViewModel.makeValue(at: index), availabilityTime)
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(rarity, "Common")
                XCTAssertEqual(fishDetailsViewModel.makeValue(at: index), rarity)
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(northernHemisphere, "11-3")
                XCTAssertEqual(fishDetailsViewModel.makeValue(at: index), northernHemisphere)
            case 6:
                XCTAssertEqual(index, 6)
                XCTAssertEqual(southernHemisphere, "5-9")
                XCTAssertEqual(fishDetailsViewModel.makeValue(at: index), southernHemisphere)
            default:
                break
            }
        }
    }
}
