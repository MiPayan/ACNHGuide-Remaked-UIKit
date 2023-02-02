//
//  SeaCreatureViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import Foundation

final class SeaCreatureViewModel {
    
    private let service: ACNHServiceProtocol
    private let mainDispatchQueue: DispatchQueueDelegate
    private let currentCalendar: CalendarDelegate
    private(set) var seaCreaturesData = [SeaCreatureData]()
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    
    init(
        service: ACNHServiceProtocol = ACNHService(),
        mainDispatchQueue: DispatchQueueDelegate = DispatchQueue.main,
        currentCalendar: CalendarDelegate = CurrentCalendar()
    ) {
        self.service = service
        self.mainDispatchQueue = mainDispatchQueue
        self.currentCalendar = currentCalendar
    }
    
    func getSeaCreatureData() {
        service.getSeaCreatureData { [weak self] result in
            guard let self else { return }
            self.mainDispatchQueue.async {
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
    
    private func makeSeaCreaturesFromTheNorthernHemisphere() -> [SeaCreatureData] {
        let (hour, month) = currentCalendar.makeCurrentCalendar()
        let filtered = seaCreaturesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
        }
        return filtered
    }
    
    private func makeSeaCreaturesFromTheSouthernHemisphere() -> [SeaCreatureData] {
        let (hour, month) = currentCalendar.makeCurrentCalendar()
        let filtered = seaCreaturesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArraySouthern.contains(month)
        }
        return filtered
    }
    
    func configureSectionCollectionView(with section: Int) -> Int {
        section == 0 ? makeSeaCreaturesFromTheNorthernHemisphere().count : makeSeaCreaturesFromTheSouthernHemisphere().count
    }
    
    func configureCollectionView(with section: Int, index: Int) -> SeaCreatureData {
        section == 0 ? makeSeaCreaturesFromTheNorthernHemisphere()[index] : makeSeaCreaturesFromTheSouthernHemisphere()[index]
    }
}
