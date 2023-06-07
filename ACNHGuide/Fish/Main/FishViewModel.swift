//
//  FishViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation

final class FishViewModel {
    
    private let service: CreatureLoaderDelegate
    private let mainDispatchQueue: DispatchQueueDelegate
    private let currentCalendar: CalendarDelegate
    private var fishesData = [FishData]()
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
    
    func getFishesData() {
        service.getFishesData { [weak self] result in
            guard let self else { return }
            mainDispatchQueue.async {
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
    
    func configureHeaderSection(with section: Int) -> String {
        section == 0 ? "northern_hemisphere".localized : "southern_hemisphere".localized
    }
    
    func configureSectionCollectionView(with section: Int) -> Int {
        section == 0 ? northernHemisphereFishes.count : southernHemisphereFishes.count
    }
    
    func makeFish(with section: Int, index: Int) -> FishData {
        section == 0 ? northernHemisphereFishes[index] : southernHemisphereFishes[index]
    }
}

private extension FishViewModel {
    
    // Sorts the fishes from the northern hemisphere using the current month and time.
    var northernHemisphereFishes: [FishData] {
        let (hour, month) = currentCalendar.currentDate
        let filtered = fishesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
        }
        return filtered
    }
    
    // Sorts the fishes from the southern hemisphere using the current month and time.
    var southernHemisphereFishes: [FishData] {
        let (hour, month) = currentCalendar.currentDate
        let filtered = fishesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArraySouthern.contains(month)
        }
        return filtered
    }
}
