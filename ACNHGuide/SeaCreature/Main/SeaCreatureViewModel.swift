//
//  SeaCreatureViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import Foundation
import Combine

final class SeaCreatureViewModel: CreatureViewModel<SeaCreatureData> {
    
    override func loadCreatures() {
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
                creatures = seaCreatures
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
        let filtered = creatures.filter {
            $0.availability.timeArray.contains(hour) && $0.availability.monthArrayNorthern.contains(month)
        }
        return filtered
    }
    
    // Sorts the sea creatures from the southern hemisphere using the current month and time.
    private var southernHemisphereSeaCreatures: [SeaCreatureData] {
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
        isShowingNorthCreature ? northernHemisphereSeaCreatures.count : southernHemisphereSeaCreatures.count
    }
    
    func makeSeaCreature(with index: Int) -> SeaCreatureData {
        isShowingNorthCreature ? northernHemisphereSeaCreatures[index] : southernHemisphereSeaCreatures[index]
    }
}
