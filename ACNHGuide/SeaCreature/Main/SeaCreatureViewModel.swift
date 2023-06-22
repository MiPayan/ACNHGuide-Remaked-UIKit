//
//  SeaCreatureViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import Foundation
import Combine

final class SeaCreatureViewModel {
    
    private let loader: Loader
    private let currentCalendar: CalendarDelegate
    private var seaCreaturesData = [SeaCreatureData]()
    private let subject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    let numberOfSections = 2
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    
    init(loader: Loader = CreatureLoader(), currentCalendar: CalendarDelegate = CurrentCalendar()) {
        self.loader = loader
        self.currentCalendar = currentCalendar
    }
    
    func loadSeaCreatures() {
        loader.loadSeaCreaturesData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    print("Is failed.")
                }
            } receiveValue: { [weak self] seaCreatures in
                guard let self else { return }
                seaCreaturesData = seaCreatures
                subject.send()
            }
            .store(in: &cancellables)
    }
    
    func setHeaderSection(with section: Int) -> String {
        section == 0 ? "northern_hemisphere".localized : "southern_hemisphere".localized
    }
    
    func configureSectionCollectionView(with section: Int) -> Int {
        section == 0 ? northernHemisphereSeaCreatures.count : southernHemisphereSeaCreatures.count
    }
    
    func makeSeaCreature(with section: Int, index: Int) -> SeaCreatureData {
        section == 0 ? northernHemisphereSeaCreatures[index] : southernHemisphereSeaCreatures[index]
    }
}

private extension SeaCreatureViewModel {
    
    // Sorts the sea creatures from the northern hemisphere using the current month and time.
    var northernHemisphereSeaCreatures: [SeaCreatureData] {
        let (hour, month) = currentCalendar.currentDate
        let filtered = seaCreaturesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
        }
        return filtered
    }
    
    // Sorts the sea creatures from the southern hemisphere using the current month and time.
    var southernHemisphereSeaCreatures: [SeaCreatureData] {
        let (hour, month) = currentCalendar.currentDate
        let filtered = seaCreaturesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArraySouthern.contains(month)
        }
        return filtered
    }
}
