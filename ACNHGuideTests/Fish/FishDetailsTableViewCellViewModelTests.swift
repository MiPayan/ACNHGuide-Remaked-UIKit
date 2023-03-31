//
//  FishDetailsTableViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 01/02/2023.
//

import XCTest
@testable import ACNHGuide

final class FishDetailsTableViewCellViewModelTests: XCTestCase {
    
    private var creaturePeekerMock: CreaturePeekerMock!
    private var creatureWriterMock: CreatureWriterMock!
    private var fishDetailsTableViewCellViewModel: FishDetailsTableViewCellViewModel!
    
    override func setUpWithError() throws {
        creaturePeekerMock = CreaturePeekerMock()
        creatureWriterMock = CreatureWriterMock()
        fishDetailsTableViewCellViewModel = FishDetailsTableViewCellViewModel(
            fishData: fishes[0],
            creaturePeeker: creaturePeekerMock,
            creatureWriter: creatureWriterMock
        )
    }
    
    override func tearDownWithError() throws {
        creaturePeekerMock = nil
        creatureWriterMock = nil
        fishDetailsTableViewCellViewModel = nil
    }
    
    func testFilename() {
        guard let fileName = fishes.first?.fileName else {
            fatalError("Tests failed: testFileName() from FishDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(fileName, "bitterling")
        XCTAssertEqual(fishDetailsTableViewCellViewModel.fileName, "Bitterling")
    }
    
    func testIconURL() {
        guard let iconURI = fishes.first?.iconURI,
              let url = URL(string: iconURI) else {
            fatalError("Tests failed: testIconURL() from FishDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/fish/1")
        XCTAssertEqual(fishDetailsTableViewCellViewModel.iconURL, url)
    }
    
    func testCatchPhrase() {
        guard let catchPhrase = fishes.first?.catchPhrase else {
            fatalError("Tests failed: testCatchPhrase() from FishDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(catchPhrase, "I caught a bitterling! It's mad at me, but only a little.")
        XCTAssertEqual(fishDetailsTableViewCellViewModel.catchPhrase, "\" I caught a bitterling! It's mad at me, but only a little. \"")
    }
    
    func testMuseumPhrase() {
        guard let museumPhrase = fishes.first?.museumPhrase else {
            fatalError("Tests failed: testMuseumPhrase() from FishDetailsTableViewCellViewModelTests")
        }
        XCTAssertEqual(museumPhrase, "Bitterlings hide their eggs inside large bivalves—like clams—where the young can stay safe until grown. The bitterling isn't being sneaky. No, their young help keep the bivalve healthy by eating invading parasites! It's a wonderful bit of evolutionary deal making, don't you think? Each one keeping the other safe... Though eating parasites does not sound like a happy childhood... Is that why the fish is so bitter?")
        XCTAssertEqual(fishDetailsTableViewCellViewModel.museumPhrase, museumPhrase)
    }
    
    func testMakeImageName() {
        for index in 0...6 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "Bells")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "FishingRod")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "FishShadow")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "Timer")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "Rarity")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "North")
            case 6:
                XCTAssertEqual(index, 6)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "South")
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
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Price")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Location")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Shadow")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Time")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Rarity")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Northern hemisphere")
            case 6:
                XCTAssertEqual(index, 6)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Southern hemisphere")
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
              let southernHemisphere = fishes.first?.availability.monthSouthern else {
            fatalError("Tests failed: testMakeValue() from FishDetailsTableViewCellViewModelTests")
        }
        
        for index in 0...6 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(price, 900)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), "900")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(location, "River")
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), location)
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(shadow, "Smallest (1)")
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), shadow)
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(time, "")
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), "Always")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(rarity, "Common")
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), rarity)
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(northernHemisphere, "11-3")
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), northernHemisphere)
            case 6:
                XCTAssertEqual(index, 6)
                XCTAssertEqual(southernHemisphere, "5-9")
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), southernHemisphere)
            default:
                break
            }
        }
    }
    
    func testIsFishAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let isFishAlreadySaved = fishDetailsTableViewCellViewModel.isFishAlreadySaved
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedParameter, "Bitterling")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(isFishAlreadySaved, false)
    }
    
    func testToggleSavedFishWhenIsNotAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = false
        let toggleSaved = fishDetailsTableViewCellViewModel.toggleSavedFish()
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureParameter, "Bitterling")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedSaveCreatureCount, 1)
        XCTAssertEqual(toggleSaved, true)
    }
    
    func testToggleSavedFishWhenIsAlreadySaved() {
        creaturePeekerMock.stubbedIsCreatureAlreadySaved = true
        let toggleSaved = fishDetailsTableViewCellViewModel.toggleSavedFish()
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureParameter, "Bitterling")
        XCTAssertEqual(creaturePeekerMock.invokedIsCreatureAlreadySavedCount, 1)
        XCTAssertEqual(creatureWriterMock.invokedDeleteCreatureCount, 1)
        XCTAssertEqual(toggleSaved, false)
    }
}
