//
//  FishViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation

final class FishViewModel {
    
    private let service: ACNHServiceProtocol
    private let mainDispatchQueue: DispatchQueueProtocol
    private let currentCalendar: CalendarProtocol
    private(set) var fishData = [FishData]()
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    
    init(
        service: ACNHServiceProtocol = ACNHService(),
        mainDispatchQueue: DispatchQueueProtocol = DispatchQueue.main,
        currentCalendar: CalendarProtocol = CurrentCalendar()
    ) {
        self.service = service
        self.mainDispatchQueue = mainDispatchQueue
        self.currentCalendar = currentCalendar
    }
    
    func getFishData() {
        service.getFishData { [weak self] result in
            guard let self else { return }
            self.mainDispatchQueue.async {
                switch result {
                case .success(let fishData):
                    self.fishData = fishData
                    self.successHandler()
                case .failure(_):
                    self.failureHandler()
                }
            }
        }
    }

    func configureSectionCollectionView(with section: Int) -> Int {
        section == 0 ? makeFishesFromTheNorthernHemisphere().count : makeFishesFromTheSouthernHemisphere().count
    }
    
    func configureCollectionView(with section: Int, index: Int) -> FishData {
        section == 0 ? makeFishesFromTheNorthernHemisphere()[index] : makeFishesFromTheSouthernHemisphere()[index]
    }
        
    func makeFishesFromTheNorthernHemisphere() -> [FishData] {
        let (hour, month) = currentCalendar.makeCurrentCalendar()
        let filtered = fishData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
        }
        return filtered
    }
    
    func makeFishesFromTheSouthernHemisphere() -> [FishData] {
        let (hour, month) = currentCalendar.makeCurrentCalendar()
        let filtered = fishData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArraySouthern.contains(month)
        }
        return filtered
    }
}
