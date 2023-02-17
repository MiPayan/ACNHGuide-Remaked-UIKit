//
//  DashboardTableViewCellViewModelTests.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 17/02/2023.
//

import XCTest
@testable import ACNHGuide

final class DashboardTableViewCellViewModelTests: XCTestCase {
    
    private var dashboardTableViewCellViewModel: DashboardTableViewCellViewModel!
    
    override func setUpWithError() throws {
        dashboardTableViewCellViewModel = DashboardTableViewCellViewModel(
            fishesData: fishes,
            seaCreaturesData: seaCreatures,
            bugsData: bugs,
            fossilsData: fossils
        )
    }
    
    override func tearDownWithError() throws {
        dashboardTableViewCellViewModel = nil
    }
    
    func testConfigureIconURL() {
        guard let iconURIfish = fishes.first?.iconURI,
              let iconURIseaCreature = seaCreatures.first?.iconURI,
              let iconURIBug = bugs.first?.iconURI,
              let imageURIFossil = fossils.first?.imageURI else {
            fatalError("")
        }
        let iconURLFishes = dashboardTableViewCellViewModel.configureIconURL(with: .fishes)
        let iconURLSeaCreatures = dashboardTableViewCellViewModel.configureIconURL(with: .seaCreatures)
        let iconURLBugs = dashboardTableViewCellViewModel.configureIconURL(with: .bugs)
        let imageURLFossils = dashboardTableViewCellViewModel.configureIconURL(with: .fossils)
        XCTAssertEqual(iconURIfish, "https://acnhapi.com/v1/icons/fish/1")
        XCTAssertEqual(iconURIseaCreature, "https://acnhapi.com/v1/icons/sea/1")
        XCTAssertEqual(iconURIBug, "https://acnhapi.com/v1/icons/bugs/1")
        XCTAssertEqual(imageURIFossil, "https://acnhapi.com/v1/images/fossils/acanthostega")
        XCTAssertEqual(iconURLFishes, URL(string: iconURIfish))
        XCTAssertEqual(iconURLSeaCreatures, URL(string: iconURIseaCreature))
        XCTAssertEqual(iconURLBugs, URL(string: iconURIBug))
        XCTAssertEqual(imageURLFossils, URL(string: imageURIFossil))
    }
    
    func testConfigureTitleText() {
        let titleTextFishes = dashboardTableViewCellViewModel.configureTitleText(with: .fishes)
        let titleTextSeaCreatures = dashboardTableViewCellViewModel.configureTitleText(with: .seaCreatures)
        let titleTextBugs = dashboardTableViewCellViewModel.configureTitleText(with: .bugs)
        let titleTextFossils = dashboardTableViewCellViewModel.configureTitleText(with: .fossils)
        XCTAssertEqual(titleTextFishes, "Fishes")
        XCTAssertEqual(titleTextSeaCreatures, "Sea creatures")
        XCTAssertEqual(titleTextBugs, "Bugs")
        XCTAssertEqual(titleTextFossils, "Fossils")
    }
    
    func testConfigureTotalText() {
        
    }
    
    func testConfigureProgressBar() {
        
    }
}
