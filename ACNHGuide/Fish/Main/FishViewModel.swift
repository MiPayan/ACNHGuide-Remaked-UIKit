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
    
    func setHeaderSection(with section: Int) -> String {
        section == 0 ? "northern_hemisphere".localized : "southern_hemisphere".localized
    }
    
    func configureSectionCollectionView(with section: Int) -> Int {
        section == 0 ? northernHemisphereFishes.count : southernHemisphereFishes.count
    }
    
    func configureCollectionView(with section: Int, index: Int) -> FishData {
        section == 0 ? northernHemisphereFishes[index] : southernHemisphereFishes[index]
    }
}

private extension FishViewModel {
    var northernHemisphereFishes: [FishData] {
        let (hour, month) = currentCalendar.getCurrentDate()
        let filtered = fishesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
        }
        return filtered
    }
    
    var southernHemisphereFishes: [FishData] {
        let (hour, month) = currentCalendar.getCurrentDate()
        let filtered = fishesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArraySouthern.contains(month)
        }
        return filtered
    }
}
