//
//  BugViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation

final class BugViewModel {
    
    private let service: ACNHServiceProtocol
    private let mainDispatchQueue: DispatchQueueDelegate
    private let currentCalendar: CalendarDelegate
    private(set) var bugData = [BugData]()
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
    
    func getBugData() {
        service.getBugData { [weak self] result in
            guard let self else { return }
            self.mainDispatchQueue.async {
                switch result {
                case .success(let bugData):
                    self.bugData = bugData
                    self.successHandler()
                case .failure(_):
                    self.failureHandler()
                }
            }
        }
    }
    
    private func makeBugsFromTheNorthernHemisphere() -> [BugData] {
        let (hour, month) = currentCalendar.makeCurrentCalendar()
        let filtered = bugData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
        }
        return filtered
    }
    
    private func makeBugsFromTheSouthernHemisphere() -> [BugData] {
        let (hour, month) = currentCalendar.makeCurrentCalendar()
        let filtered = bugData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArraySouthern.contains(month)
        }
        return filtered
    }
    
    func configureSectionCollectionView(with section: Int) -> Int {
        section == 0 ? makeBugsFromTheNorthernHemisphere().count : makeBugsFromTheSouthernHemisphere().count
    }
    
    func configureCollectionView(with section: Int, index: Int) -> BugData {
        section == 0 ? makeBugsFromTheNorthernHemisphere()[index] : makeBugsFromTheSouthernHemisphere()[index]
    }
}
