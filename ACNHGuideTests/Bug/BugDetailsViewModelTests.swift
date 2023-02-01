//
//  BugDetailsViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 01/02/2023.
//

import XCTest
@testable import ACNHGuide

final class BugDetailsViewModelTests: XCTestCase {
    
    private var bugDetailsViewModel: BugDetailsViewModel!
    
    override func setUpWithError() throws {
        bugDetailsViewModel = BugDetailsViewModel(bugData: bugs[0])
    }
    
    override func tearDownWithError() throws {
        bugDetailsViewModel = nil
    }
    
    func testFileName() {
        guard let fileName = bugs.first?.fileName else { return }
        let formatFileName = fileName.replaceCharacter("_", by: "").capitalized
        XCTAssertEqual(fileName, "common_butterfly")
        XCTAssertEqual(bugDetailsViewModel.fileName, formatFileName)
    }
    
    func testIconUri() {
        guard let iconURI = bugs.first?.iconURI,
              let url = URL(string: iconURI) else { return }
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/bugs/1")
        XCTAssertEqual(bugDetailsViewModel.iconURL, url)
    }
    
    func testCatchPhrase() {
        guard let catchPhrase = bugs.first?.catchPhrase else { return }
        XCTAssertEqual(catchPhrase, "I caught a common butterfly! They often flutter by!")
        XCTAssertEqual(bugDetailsViewModel.catchPhrase, "\" \(catchPhrase) \"")
    }
    
    func testPrice() {
        guard let price = bugs.first?.price else { return }
        XCTAssertEqual(price, 160)
        XCTAssertEqual(bugDetailsViewModel.price, String(price))
    }
    
    func testAvailabilityLocation() {
        guard let location = bugs.first?.availability.location else { return }
        XCTAssertEqual(location, "Flying")
        XCTAssertEqual(bugDetailsViewModel.availabilityLocation, location)
    }
    
    func testAvailabilityTime() {
        guard let availabilityTime = bugs.first?.availability.time else { return }
        XCTAssertEqual(availabilityTime, "4am - 7pm")
        XCTAssertEqual(bugDetailsViewModel.availabilityTime, availabilityTime)
    }
    
    func testRarity() {
        guard let rarity = bugs.first?.availability.rarity else { return }
        XCTAssertEqual(rarity, "Common")
        XCTAssertEqual(bugDetailsViewModel.rarity, rarity)
    }
    
    func testNorthernHemisphereAvailability() {
        guard let monthNorthern = bugs.first?.availability.monthNorthern else { return }
        XCTAssertEqual(monthNorthern, "9-6")
        XCTAssertEqual(bugDetailsViewModel.northernHemisphereAvailability, monthNorthern)
    }
    
    func testSouthernHemisphereAvailability() {
        guard let monthSouthern = bugs.first?.availability.monthSouthern else { return }
        XCTAssertEqual(monthSouthern, "3-12")
        XCTAssertEqual(bugDetailsViewModel.southernHemisphereAvailability, monthSouthern)
    }
    
    func testMuseumPhrase() {
        guard let museumPhrase = bugs.first?.museumPhrase else { return }
        XCTAssertEqual(museumPhrase, "The common butterfly would have you believe it is but a beautiful friend flitting prettily about the flowers. Bah, I say! They may seem innocent things with their pretty white wings, but they hide a dark side! The common butterfly caterpillar is called a cabbage worm, you see, and it's a most voracious pest. The ravenous beasts chew through cabbage, broccoli, kale and the like with a devastating gusto. And my feathers! Their green coloring is truly GROSS! A hoo-rrific hue, I say.")
        XCTAssertEqual(bugDetailsViewModel.museumPhrase, museumPhrase)
    }
    
    func testMakeImageName() {
        for index in 0...5 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(bugDetailsViewModel.makeImageName(at: index), "Bells")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(bugDetailsViewModel.makeImageName(at: index), "Grass")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(bugDetailsViewModel.makeImageName(at: index), "Timer")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(bugDetailsViewModel.makeImageName(at: index), "Rarity")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(bugDetailsViewModel.makeImageName(at: index), "North")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(bugDetailsViewModel.makeImageName(at: index), "South")
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
                XCTAssertEqual(bugDetailsViewModel.makeTitle(at: index), "Price")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(bugDetailsViewModel.makeTitle(at: index), "Location")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(bugDetailsViewModel.makeTitle(at: index), "Time")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(bugDetailsViewModel.makeTitle(at: index), "Rarity")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(bugDetailsViewModel.makeTitle(at: index), "Northern hemisphere")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(bugDetailsViewModel.makeTitle(at: index), "Southern hemisphere")
            default:
                break
            }
        }
    }
    
    func testMakeValue() {
        guard let price = bugs.first?.price,
              let location = bugs.first?.availability.location,
              let time = bugs.first?.availability.time,
              let rariry = bugs.first?.availability.rarity,
              let northernHemisphere = bugs.first?.availability.monthNorthern,
              let southernHemisphere = bugs.first?.availability.monthSouthern else { return }
        
        for index in 0...6 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(price, 160)
                XCTAssertEqual(bugDetailsViewModel.makeValue(at: index), String(price))
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(location, "Flying")
                XCTAssertEqual(bugDetailsViewModel.makeValue(at: index), location)
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(time, "4am - 7pm")
                
                let availabilityTime = time.isEmpty ? "Always" : bugDetailsViewModel.availabilityTime
                XCTAssertEqual(availabilityTime, "4am - 7pm")
                XCTAssertEqual(bugDetailsViewModel.makeValue(at: index), availabilityTime)
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(rariry, "Common")
                XCTAssertEqual(bugDetailsViewModel.makeValue(at: index), rariry)
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(northernHemisphere, "9-6")
                XCTAssertEqual(bugDetailsViewModel.makeValue(at: index), northernHemisphere)
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(southernHemisphere, "3-12")
                XCTAssertEqual(bugDetailsViewModel.makeValue(at: index), southernHemisphere)
            default:
                break
            }
        }
    }
}
