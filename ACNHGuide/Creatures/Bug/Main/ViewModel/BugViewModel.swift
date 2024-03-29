//
//  BugViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation
import Combine

final class BugViewModel: CreatureViewModel<BugData> {
    
    override func loadCreature() {
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
                creatures = bugs
                subject.send()
            }
            .store(in: &cancellables)
        super.loadCreature()
    }
}

// MARK: - Configure CollectionView

extension BugViewModel {
    
    // Sorts the bugs from the northern hemisphere using the current month and time.
    private var northernHemisphereBugs: [BugData] {
        let (hour, month) = currentCalendar.currentDate
        let filtered = creatures.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
        }
        return filtered
    }
    
    // Sorts the bugs from the southern hemisphere using the current month and time.
    private var southernHemisphereBugs: [BugData] {
        let (hour, month) = currentCalendar.currentDate
        let filtered = creatures.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArraySouthern.contains(month)
        }
        return filtered
    }
    
    var header: String {
        isShowingNorthCreature ? "northern_hemisphere".localized : "southern_hemisphere".localized
    }
    
    var numberOfItemsInSection: Int {
        isShowingNorthCreature ? northernHemisphereBugs.count : southernHemisphereBugs.count
    }
    
    func makeBug(with index: Int) -> BugData {
        isShowingNorthCreature ? northernHemisphereBugs[index] : southernHemisphereBugs[index]
    }
}
