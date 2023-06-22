//
//  FishViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation
import Combine

final class FishViewModel {
    
    private let loader: Loader
    private let currentCalendar: CalendarDelegate
    private(set) var fishesData = [FishData]()
    private let subject = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    let numberOfSections = 2
    let failureHandler = PassthroughSubject<Error, Never>()
    var reloadData: AnyPublisher<Void, Never> {
           subject.eraseToAnyPublisher()
       }
    
    init(loader: Loader = CreatureLoader(), currentCalendar: CalendarDelegate = CurrentCalendar()) {
        self.loader = loader
        self.currentCalendar = currentCalendar
    }
    
    func loadFishesData() {
        loader.loadFishesData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.failureHandler.send(error)
                }
            } receiveValue: { [weak self] fishes in
                guard let self else { return }
                fishesData = fishes
                subject.send()
            }
            .store(in: &cancellables)
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
