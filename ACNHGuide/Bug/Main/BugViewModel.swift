//
//  BugViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation

final class BugViewModel {
    
    private let service: Service
    private let mainDispatchQueue: DispatchQueueDelegate
    private let currentCalendar: CalendarDelegate
    private var bugsData = [BugData]()
    let numberOfSections = 2
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    
    init(
        service: Service = ACNHService(),
        mainDispatchQueue: DispatchQueueDelegate = DispatchQueue.main,
        currentCalendar: CalendarDelegate = CurrentCalendar()
    ) {
        self.service = service
        self.mainDispatchQueue = mainDispatchQueue
        self.currentCalendar = currentCalendar
    }
    
    func getBugsData() {
        service.getBugsData { [weak self] result in
            guard let self else { return }
            self.mainDispatchQueue.async {
                switch result {
                case .success(let bugsData):
                    self.bugsData = bugsData
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
        section == 0 ? northernHemisphereBugs.count : southernHemisphereBugs.count
    }
    
    func makeBug(with section: Int, index: Int) -> BugData {
        section == 0 ? northernHemisphereBugs[index] : southernHemisphereBugs[index]
    }
}

private extension BugViewModel {
    
    // Sorts the bugs from the northern hemisphere using the current month and time.
    var northernHemisphereBugs: [BugData] {
        let (hour, month) = currentCalendar.getCurrentDate()
        let filtered = bugsData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
        }
        return filtered
    }
    
    // Sorts the bugs from the southern hemisphere using the current month and time.
    var southernHemisphereBugs: [BugData] {
        let (hour, month) = currentCalendar.getCurrentDate()
        let filtered = bugsData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArraySouthern.contains(month)
        }
        return filtered
    }
}
