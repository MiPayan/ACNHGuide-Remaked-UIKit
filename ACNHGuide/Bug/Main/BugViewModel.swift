//
//  BugViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation
import Combine

final class BugViewModel {
    
    private let loader: Loader
    private let currentCalendar: CalendarDelegate
    private var bugsData = [BugData]()
    private let subject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    let numberOfSections = 2
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    
    init(loader: Loader = CreatureLoader(), currentCalendar: CalendarDelegate = CurrentCalendar()) {
        self.loader = loader
        self.currentCalendar = currentCalendar
    }
    
    func loadBugs() {
        loader.loadBugsData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    print("Is failed.")
                }
            } receiveValue: { [weak self] bugs in
                guard let self else { return }
                bugsData = bugs
                subject.send()
            }
            .store(in: &cancellables)
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
        let (hour, month) = currentCalendar.currentDate
        let filtered = bugsData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
        }
        return filtered
    }
    
    // Sorts the bugs from the southern hemisphere using the current month and time.
    var southernHemisphereBugs: [BugData] {
        let (hour, month) = currentCalendar.currentDate
        let filtered = bugsData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArraySouthern.contains(month)
        }
        return filtered
    }
}
