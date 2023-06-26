//
//  ProgressDashboardViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 27/01/2023.
//

import Foundation
import Combine

final class ProgressDashboardViewModel {
    
    private let loader: Loader
    private(set) var fishes = [FishData]()
    private(set) var seaCreatures = [SeaCreatureData]()
    private(set) var bugs = [BugData]()
    private(set) var fossils = [FossilData]()
    let numberOfRowsInSection = 4
    private let subject = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    let failureHandler = PassthroughSubject<Error, Never>()
    var reloadData: AnyPublisher<Void, Never> {
        subject.eraseToAnyPublisher()
    }
    
    init(loader: Loader = CreatureLoader()) {
        self.loader = loader
    }
    
    func loadCreatures() {
        loader.loadCreaturesData()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    failureHandler.send(error)
                }
            } receiveValue: { [unowned self] (fishes: [FishData], seaCreatures: [SeaCreatureData], bugs: [BugData], fossils: [FossilData]) in
                self.fishes = fishes
                self.seaCreatures = seaCreatures
                self.bugs = bugs
                self.fossils = fossils
                self.subject.send()
            }
            .store(in: &cancellables)
    }
}
