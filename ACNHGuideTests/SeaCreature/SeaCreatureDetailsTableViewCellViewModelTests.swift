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
    
    func testPrice() {
        guard let price = seaCreatures.first?.price else {
            fatalError("Tests failed: testPrice() from SeaCreatureDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(price, 600)
        XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.price, "600")
    }
    
    func testShadow() {
        guard let shadow = seaCreatures.first?.shadow else {
            fatalError("Tests failed: testShadow() from SeaCreatureDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(shadow, "Large")
        XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.shadow, shadow)
    }
    
    func testAvailabilityTime() {
        guard let time = seaCreatures.first?.availability.time else {
            fatalError("Tests failed: testAvailabilityTime() from SeaCreatureDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(time, "")
        XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.availabilityTime, "Always")
    }
    
    func testSpeed() {
        guard let speed = seaCreatures.first?.speed else {
            fatalError("Tests failed: testSpeed() from SeaCreatureDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(speed, "Stationary")
        XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.speed, speed)
    }
    
    func testNorthernHemisphereAvailability() {
        guard let monthNorthern = seaCreatures.first?.availability.monthNorthern else {
            fatalError("Tests failed: testNorthernHemisphereAvailability() from SeaCreatureDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(monthNorthern, "10-7")
        XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.northernHemisphereAvailability, monthNorthern)
    }
    
    func testSouthernHemisphereAvailability() {
        guard let monthSouthern = seaCreatures.first?.availability.monthSouthern else {
            fatalError("Tests failed: testSouthernHemisphereAvailability() from SeaCreatureDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(monthSouthern, "4-1")
        XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.southernHemisphereAvailability, monthSouthern)
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
    
    func testMakeValue() {
        guard let price = seaCreatures.first?.price,
              let shadow = seaCreatures.first?.shadow,
              let time = seaCreatures.first?.availability.time,
              let speed = seaCreatures.first?.speed,
              let northernHemisphere = seaCreatures.first?.availability.monthNorthern,
              let southernHemisphere = seaCreatures.first?.availability.monthSouthern else {
            fatalError("Tests failed: testMakeValue() from SeaCreatureDetailsTableViewCellViewModelTests")
        }
        
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
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = true
        let testFileName = "TestFilename"
        let isCreatureAlreadySaved = creaturePeekerMock.isCreatureAlreadySaved(fileName: testFileName)
        XCTAssertEqual(isCreatureAlreadySaved, true)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "TestFilename")
        XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.isSeaCreatureAlreadySaved, true)
    }
    
    func testToggleSeaCreatureWhenIsNotAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let testFileName = "TestFileName"
        let isCreatureAlreadySaved = creaturePeekerMock.isCreatureAlreadySaved(fileName: testFileName)
        creatureWriterMock.saveCreature(fileName: testFileName)
        XCTAssertEqual(isCreatureAlreadySaved, false)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "TestFileName")
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureParameter, "TestFileName")
        XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.toggleSavedSeaCreature(), true)
    }
    
    func testToggleSeaCreatureWhenIsAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = true
        let testFileName = "TestFileName"
        let isCreatureAlreadySaved = creaturePeekerMock.isCreatureAlreadySaved(fileName: testFileName)
        creatureWriterMock.deleteCreature(fileName: testFileName)
        XCTAssertEqual(isCreatureAlreadySaved, true)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "TestFileName")
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureParameter, "TestFileName")
        XCTAssertEqual(seaCreatureDetailsTableViewCellViewModel.toggleSavedSeaCreature(), false)
    }
}

