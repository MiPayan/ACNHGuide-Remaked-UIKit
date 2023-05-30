//
//  SeaCreatureDetailsTableViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 01/02/2023.
//

import XCTest
@testable import ACNHGuide

final class SeaCreatureDetailsTableViewCellViewModelTests: XCTestCase {
    
    private var seaCreatureDetailsTableViewCellViewModel: SeaCreaturesDetailsTableViewCellViewModel!
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatureWriterMock: CreatureWriterMock!
    
    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatureWriterMock = CreatureWriterMock()
        seaCreatureDetailsTableViewCellViewModel = SeaCreaturesDetailsTableViewCellViewModel(
            seaCreatureData: seaCreatures[0],
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatureWriterMock
        )
    }
    
    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatureWriterMock = nil
        seaCreatureDetailsTableViewCellViewModel = nil
    }
    
    func testFileName() {
        guard let fileName = seaCreatures.first?.fileName else {
            fatalError("Tests failed: testFileName() from SeaCreatureDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(fileName, "seaweed")
        XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.fileName, "Seaweed")
    }
    
    func testIconURL() {
        guard let iconURI = seaCreatures.first?.iconURI,
              let url = URL(string: iconURI) else {
            fatalError("Tests failed: testIconURL() from SeaCreatureDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/sea/1")
        XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.iconURL, url)
    }
    
    func testCatchPhrase() {
        guard let catchPhrase = seaCreatures.first?.catchPhrase else {
            fatalError("Tests failed: testCatchPhrase() from SeaCreatureDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(catchPhrase, "I got some seaweed! I couldn't kelp myself.")
        XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.catchPhrase, "\" I got some seaweed! I couldn't kelp myself. \"")
    }
    
    func testMuseumPhrase() {
        guard let museumPhrase = seaCreatures.first?.museumPhrase else {
            fatalError("Tests failed: testMuseumPhrase() from SeaCreatureDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(museumPhrase, "Let it be known that seaweed is a misnomer of the highest order! That is, it is not a noxious weed so much as it is a marine algae most beneficial to life on land and sea. Seaweed, you see, provides essential habitat and food for all manner of marine creatures. And it creates a great deal of the oxygen we land lovers love to breath too, hoo! And yet, I can't help but shudder when the slimy stuff touches my toes during a swim. Hoot! The horror!")
        XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.museumPhrase, museumPhrase)
    }
    
    func testMakeImageName() {
        for index in 0...5 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeImageName(at: index), "Bells")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeImageName(at: index), "SeaCreatureShadow")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeImageName(at: index), "Timer")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeImageName(at: index), "Speedmeter")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeImageName(at: index), "North")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeImageName(at: index), "South")
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
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeTitle(at: index), "Price")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeTitle(at: index), "Shadow")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeTitle(at: index), "Time")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeTitle(at: index), "Speed")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeTitle(at: index), "Northern hemisphere")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeTitle(at: index), "Southern hemisphere")
            default:
                break
            }
        }
    }
    
    func testMakeValue() throws {
        let price = try XCTUnwrap(seaCreatures.first?.price)
        let shadow = try XCTUnwrap(seaCreatures.first?.shadow)
        let time = try XCTUnwrap(seaCreatures.first?.availability.time)
        let speed = try XCTUnwrap(seaCreatures.first?.speed)
        let northernHemisphere = try XCTUnwrap(seaCreatures.first?.availability.monthNorthern)
        let southernHemisphere = try XCTUnwrap(seaCreatures.first?.availability.monthSouthern)
        
        for index in 0...6 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(price, 600)
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeValue(at: index), "600")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(shadow, "Large")
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeValue(at: index), shadow)
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(time, "")
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeValue(at: index), "Always")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(speed, "Stationary")
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeValue(at: index), speed)
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(northernHemisphere, "10-7")
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeValue(at: index), northernHemisphere)
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(southernHemisphere, "4-1")
                XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.makeValue(at: index), southernHemisphere)
            default:
                break
            }
        }
    }
    
    func testIsSeaCreatureAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let isSeaCreatureAlreadySaved = seaCreatureDetailsTableViewCellViewModel.isSeaCreatureAlreadySaved
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "Seaweed")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(isSeaCreatureAlreadySaved, false)
    }
    
    func testToggleSeaCreatureWhenIsNotAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let toggleSaved = seaCreatureDetailsTableViewCellViewModel.toggleSavedSeaCreature()
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureParameter, "Seaweed")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureCount, 1)
        XCTAssertEqual(toggleSaved, true)
    }
    
    func testToggleSeaCreatureWhenIsAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = true
        let toggleSaved = seaCreatureDetailsTableViewCellViewModel.toggleSavedSeaCreature()
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureParameter, "Seaweed")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureCount, 1)
        XCTAssertEqual(toggleSaved, false)
    }
}

