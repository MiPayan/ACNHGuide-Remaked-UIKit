//
//  SeaCreatureViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import Foundation

final class SeaCreatureViewModel {
    
    private let service: CreatureLoaderDelegate
    private let mainDispatchQueue: DispatchQueueDelegate
    private let currentCalendar: CalendarDelegate
    private var seaCreaturesData = [SeaCreatureData]()
    let numberOfSections = 2
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    
    init(
        service: CreatureLoaderDelegate = CreatureLoader(),
        mainDispatchQueue: DispatchQueueDelegate = DispatchQueue.main,
        currentCalendar: CalendarDelegate = CurrentCalendar()
    ) {
        self.service = service
        self.mainDispatchQueue = mainDispatchQueue
        self.currentCalendar = currentCalendar
    }
    
    func getSeaCreaturesData() {
        service.getSeaCreaturesData { [weak self] result in
            guard let self else { return }
            mainDispatchQueue.async {
                switch result {
                case .success(let seaCreature):
                    self.seaCreaturesData = seaCreature
                    self.successHandler()
                case .failure(_):
                    self.failureHandler()
                }
            }
        }
    }
    
    func setHeaderSection(with section: Int) -> String {
        section == 0 ? "northern_hemisphere".localized : "southern_hemisphere".localized
    }
    
    func configureSectionCollectionView(with section: Int) -> Int {
        section == 0 ? northernHemisphereSeaCreatures.count : southernHemisphereSeaCreatures.count
    }
    
    func makeSeaCreature(with section: Int, index: Int) -> SeaCreatureData {
        section == 0 ? northernHemisphereSeaCreatures[index] : southernHemisphereSeaCreatures[index]
    }
}

private extension SeaCreatureViewModel {
    
    // Sorts the sea creatures from the northern hemisphere using the current month and time.
    var northernHemisphereSeaCreatures: [SeaCreatureData] {
        let (hour, month) = currentCalendar.currentDate
        let filtered = seaCreaturesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
        }
        return filtered
    }
    
    // Sorts the sea creatures from the southern hemisphere using the current month and time.
    var southernHemisphereSeaCreatures: [SeaCreatureData] {
        let (hour, month) = currentCalendar.currentDate
        let filtered = seaCreaturesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArraySouthern.contains(month)
        }
        return filtered
    }
}
