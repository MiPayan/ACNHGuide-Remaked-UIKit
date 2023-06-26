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
    var cancellables = Set<AnyCancellable>()
    let failureHandler = PassthroughSubject<Error, Never>()
    var reloadData: AnyPublisher<Void, Never> {
        subject.eraseToAnyPublisher()
    }
    
    var isShowingNorthBug: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "Hemisphere")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Hemisphere")
        }
    }
    
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
                case .failure(let error):
                    self.failureHandler.send(error)
                }
            } receiveValue: { [weak self] bugs in
                guard let self else { return }
                bugsData = bugs
                subject.send()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Configure CollectionView

extension BugViewModel {
    
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
    
    var header: String {
        isShowingNorthBug ? "northern_hemisphere".localized : "southern_hemisphere".localized
    }
    
    var numberOfItemsInSection: Int {
        isShowingNorthBug ? northernHemisphereBugs.count : southernHemisphereBugs.count
    }
    
    func makeBug(with index: Int) -> BugData {
        isShowingNorthBug ? northernHemisphereBugs[index] : southernHemisphereBugs[index]
    }
}
