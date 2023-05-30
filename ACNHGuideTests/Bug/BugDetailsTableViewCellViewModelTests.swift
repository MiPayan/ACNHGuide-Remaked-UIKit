//
//  BugDetailsTableViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 01/02/2023.
//

import XCTest
@testable import ACNHGuide

final class BugDetailsTableViewCellViewModelTests: XCTestCase {
    
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatureWriterMock: CreatureWriterMock!
    private var bugDetailsTableViewCellViewModel: BugDetailsTableViewCellViewModel!
    
    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatureWriterMock = CreatureWriterMock()
        bugDetailsTableViewCellViewModel = BugDetailsTableViewCellViewModel(
            bugData: bugs[0],
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatureWriterMock
        )
    }
    
    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatureWriterMock = nil
        bugDetailsTableViewCellViewModel = nil
    }
    
    func testFileName() throws {
        let fileName = try XCTUnwrap(bugs.first?.fileName, "Tests failed: testFileName() from BugDetailsTableViewCellViewModelTests")
        XCTAssertEqual(fileName, "common_butterfly")
        XCTAssertEqual(bugDetailsTableViewCellViewModel.fileName, "Common Butterfly")
    }
    
    func testIconURL() throws {
        let iconURI = try XCTUnwrap(bugs.first?.iconURI, "Tests failed: testIconURL() from BugDetailsTableViewCellViewModelTests")
        let url = URL(string: iconURI)
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/bugs/1")
        XCTAssertEqual(bugDetailsTableViewCellViewModel.iconURL, url)
    }
    
    func testCatchPhrase() throws {
        let catchPhrase = try XCTUnwrap(bugs.first?.catchPhrase, "Tests failed: testCatchPhrase() from BugDetailsTableViewCellViewModelTests")
        XCTAssertEqual(catchPhrase, "I caught a common butterfly! They often flutter by!")
        XCTAssertEqual(bugDetailsTableViewCellViewModel.catchPhrase, "\" I caught a common butterfly! They often flutter by! \"")
    }
        
    func testMuseumPhrase() throws {
        let museumPhrase = try XCTUnwrap(bugs.first?.museumPhrase, "Tests failed: testMuseumPhrase() from BugDetailsTableViewCellViewModelTests")
        XCTAssertEqual(museumPhrase, "The common butterfly would have you believe it is but a beautiful friend flitting prettily about the flowers. Bah, I say! They may seem innocent things with their pretty white wings, but they hide a dark side! The common butterfly caterpillar is called a cabbage worm, you see, and it's a most voracious pest. The ravenous beasts chew through cabbage, broccoli, kale and the like with a devastating gusto. And my feathers! Their green coloring is truly GROSS! A hoo-rrific hue, I say.")
        XCTAssertEqual(bugDetailsTableViewCellViewModel.museumPhrase, museumPhrase)
    }
    
    func testMakeImageName() {
        for index in 0...6 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeImageName(at: index), "Bells")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeImageName(at: index), "Flick")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeImageName(at: index), "Grass")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeImageName(at: index), "Timer")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeImageName(at: index), "Rarity")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeImageName(at: index), "North")
            case 6:
                XCTAssertEqual(index, 6)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeImageName(at: index), "South")
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
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeTitle(at: index), "Price")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeTitle(at: index), "Flick's price")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeTitle(at: index), "Location")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeTitle(at: index), "Time")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeTitle(at: index), "Rarity")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeTitle(at: index), "Northern hemisphere")
            case 6:
                XCTAssertEqual(index, 6)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeTitle(at: index), "Southern hemisphere")
            default:
                break
            }
        }
    }
    
    func testMakeValue() throws {
        let price = try XCTUnwrap(bugs.first?.price)
        let priceFlick = try XCTUnwrap(bugs.first?.priceFlick)
        let location = try XCTUnwrap(bugs.first?.availability.location)
        let time = try XCTUnwrap(bugs.first?.availability.time)
        let rariry = try XCTUnwrap(bugs.first?.availability.rarity)
        let northernHemisphere = try XCTUnwrap(bugs.first?.availability.monthNorthern)
        let southernHemisphere = try XCTUnwrap(bugs.first?.availability.monthSouthern)
        
        for index in 0...6 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(price, 160)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeValue(at: index), String(price))
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(priceFlick, 240)
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeValue(at: index), String(priceFlick))
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(location, "Flying")
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeValue(at: index), location)
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(time, "4am - 7pm")
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeValue(at: index), time)
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(rariry, "Common")
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeValue(at: index), rariry)
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(northernHemisphere, "9-6")
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeValue(at: index), northernHemisphere)
            case 6:
                XCTAssertEqual(index, 6)
                XCTAssertEqual(southernHemisphere, "3-12")
                XCTAssertEqual(bugDetailsTableViewCellViewModel.makeValue(at: index), southernHemisphere)
            default:
                break
            }
        }
    }
    
    func testIsBugAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let isBugAlreadySaved = bugDetailsTableViewCellViewModel.isBugAlreadySaved
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "Common Butterfly")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(isBugAlreadySaved, false)
    }
    
    func testToggleBugWhenIsNotAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let toggleSaved = bugDetailsTableViewCellViewModel.toggleSavedBug()
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureParameter, "Common Butterfly")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureCount, 1)
        XCTAssertEqual(toggleSaved, true)
    }
    
    func testToggleBugWhenIsAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = true
        let toggleSaved = bugDetailsTableViewCellViewModel.toggleSavedBug()
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureParameter, "Common Butterfly")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureCount, 1)
        XCTAssertEqual(toggleSaved, false)
    }
}
