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
    var isShowingNorthSeaCreature = true
    var cancellables = Set<AnyCancellable>()
    private let subject = PassthroughSubject<Void, Never>()
    let failureHandler = PassthroughSubject<Error, Never>()
    var reloadData: AnyPublisher<Void, Never> {
        subject.eraseToAnyPublisher()
    }
    
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
                case .failure(let error):
                    self.failureHandler.send(error)
                }
            } receiveValue: { [weak self] seaCreatures in
                guard let self else { return }
                seaCreaturesData = seaCreatures
                subject.send()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Configure CollectionView

extension SeaCreatureViewModel {
    
    // Sorts the sea creatures from the northern hemisphere using the current month and time.
    private var northernHemisphereSeaCreatures: [SeaCreatureData] {
        let (hour, month) = currentCalendar.currentDate
        let filtered = seaCreaturesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
        }
        return filtered
    }
    
    // Sorts the sea creatures from the southern hemisphere using the current month and time.
    private var southernHemisphereSeaCreatures: [SeaCreatureData] {
        let (hour, month) = currentCalendar.currentDate
        let filtered = seaCreaturesData.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArraySouthern.contains(month)
        }
        return filtered
    }
    
    var header: String {
        isShowingNorthSeaCreature ? "northern_hemisphere".localized : "southern_hemisphere".localized
    }
    
    var numberOfItemsInSection: Int {
        isShowingNorthSeaCreature ? northernHemisphereSeaCreatures.count : southernHemisphereSeaCreatures.count
    }
    
    func makeSeaCreature(with index: Int) -> SeaCreatureData {
        isShowingNorthSeaCreature ? northernHemisphereSeaCreatures[index] : southernHemisphereSeaCreatures[index]
    }
}
