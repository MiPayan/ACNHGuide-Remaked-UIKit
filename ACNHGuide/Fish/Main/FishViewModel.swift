//
//  FishViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation

final class FishViewModel {
    
    private let service: ACNHServiceProtocol
    private let mainDispatchQueue: DispatchQueueDelegate
    private let currentCalendar: CalendarDelegate
    private(set) var fishesData = [FishData]()
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

    func getFishData() {
        service.getFishData { [weak self] result in
            guard let self else { return }
            self.mainDispatchQueue.async {
                switch result {
                case .success(let fishesData):
                    self.fishesData = fishesData
                    self.successHandler()
                case .failure(_):
                    self.failureHandler()
                }
            }
        }
    }
    
    func makeFishesFromTheNorthernHemisphere() -> [FishData] {
        let (hour, month) = currentCalendar.makeCurrentCalendar()
        let filtered = fishesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
        }
        return filtered
    }
    
    func makeFishesFromTheSouthernHemisphere() -> [FishData] {
        let (hour, month) = currentCalendar.makeCurrentCalendar()
        let filtered = fishesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArraySouthern.contains(month)
        }
        return filtered
    }
    
    func configureSectionCollectionView(with section: Int) -> Int {
        section == 0 ? makeFishesFromTheNorthernHemisphere().count : makeFishesFromTheSouthernHemisphere().count
    }
    
    func configureCollectionView(with section: Int, index: Int) -> FishData {
        section == 0 ? makeFishesFromTheNorthernHemisphere()[index] : makeFishesFromTheSouthernHemisphere()[index]
    }
}
