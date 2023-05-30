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
    
    func testFilename() throws {
        let fileName = try XCTUnwrap(fishes.first?.fileName, "Tests failed: testFilename() from FishDetailsTableViewCellViewModelTests")
        XCTAssertEqual(fileName, "bitterling")
        XCTAssertEqual(fishDetailsTableViewCellViewModel.fileName, "Bitterling")
    }
    
    func testIconURL() throws {
        let iconURI = try XCTUnwrap(fishes.first?.iconURI, "Tests failed: testIconURL() from FishDetailsTableViewCellViewModelTests")
        let url = URL(string: iconURI)
        XCTAssertEqual(iconURI, "https://acnhapi.com/v1/icons/fish/1")
        XCTAssertEqual(fishDetailsTableViewCellViewModel.iconURL, url)
    }
    
    func testCatchPhrase() throws {
        let catchPhrase = try XCTUnwrap(fishes.first?.catchPhrase, "Tests failed: testCatchPhrase() from FishDetailsTableViewCellViewModelTests")
        XCTAssertEqual(catchPhrase, "I caught a bitterling! It's mad at me, but only a little.")
        XCTAssertEqual(fishDetailsTableViewCellViewModel.catchPhrase, "\" I caught a bitterling! It's mad at me, but only a little. \"")
    }
    
    func testMuseumPhrase() throws {
        let museumPhrase = try XCTUnwrap(fishes.first?.museumPhrase, "Tests failed: testMuseumPhrase() from FishDetailsTableViewCellViewModelTests")
        XCTAssertEqual(museumPhrase, "Bitterlings hide their eggs inside large bivalves—like clams—where the young can stay safe until grown. The bitterling isn't being sneaky. No, their young help keep the bivalve healthy by eating invading parasites! It's a wonderful bit of evolutionary deal making, don't you think? Each one keeping the other safe... Though eating parasites does not sound like a happy childhood... Is that why the fish is so bitter?")
        XCTAssertEqual(fishDetailsTableViewCellViewModel.museumPhrase, museumPhrase)
    }
    
    func testMakeImageName() {
        for index in 0...7 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "Bells")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "CJ")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "FishingRod")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "FishShadow")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "Timer")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "Rarity")
            case 6:
                XCTAssertEqual(index, 6)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "North")
            case 7:
                XCTAssertEqual(index, 7)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeImageName(at: index), "South")
            default:
                break
            }
        }
    }
    
    func testMakeTitle() {
        for index in 0...7 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Price")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "C.J's price")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Location")
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Shadow")
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Time")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Rarity")
            case 6:
                XCTAssertEqual(index, 6)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Northern hemisphere")
            case 7:
                XCTAssertEqual(index, 7)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeTitle(at: index), "Southern hemisphere")
            default:
                break
            }
        }
    }
    
    func testMakeValue() throws {
        let price = try XCTUnwrap(fishes.first?.price)
        let priceCJ = try XCTUnwrap(fishes.first?.priceCj)
        let location = try XCTUnwrap(fishes.first?.availability.location)
        let shadow = try XCTUnwrap(fishes.first?.shadow)
        let time = try XCTUnwrap(fishes.first?.availability.time)
        let rarity = try XCTUnwrap(fishes.first?.availability.rarity)
        let northernHemisphere = try XCTUnwrap(fishes.first?.availability.monthNorthern)
        let southernHemisphere = try XCTUnwrap(fishes.first?.availability.monthSouthern)
        
        for index in 0...7 {
            switch index {
            case 0:
                XCTAssertEqual(index, 0)
                XCTAssertEqual(price, 900)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), "900")
            case 1:
                XCTAssertEqual(index, 1)
                XCTAssertEqual(priceCJ, 1350)
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), "1350")
            case 2:
                XCTAssertEqual(index, 2)
                XCTAssertEqual(location, "River")
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), location)
            case 3:
                XCTAssertEqual(index, 3)
                XCTAssertEqual(shadow, "Smallest (1)")
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), shadow)
            case 4:
                XCTAssertEqual(index, 4)
                XCTAssertEqual(time, "")
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), "Always")
            case 5:
                XCTAssertEqual(index, 5)
                XCTAssertEqual(rarity, "Common")
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), rarity)
            case 6:
                XCTAssertEqual(index, 6)
                XCTAssertEqual(northernHemisphere, "11-3")
                XCTAssertEqual(fishDetailsTableViewCellViewModel.makeValue(at: index), northernHemisphere)
            case 7:
                XCTAssertEqual(index, 7)
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
