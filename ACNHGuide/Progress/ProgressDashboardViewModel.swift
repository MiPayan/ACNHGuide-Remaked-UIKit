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
    private(set) var fishesData = [FishData]()
    private(set) var seaCreaturesData = [SeaCreatureData]()
    private(set) var bugsData = [BugData]()
    private(set) var fossilsData = [FossilData]()
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
    
//    TODO: Replace DispatchGroup using Combine to load the creatures.
    
    func loadCreatures() {
    }
}
