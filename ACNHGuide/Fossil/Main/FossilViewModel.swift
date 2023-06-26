//
//  FossilViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation
import Combine

final class FossilViewModel {
    
    private let loader: Loader
    private(set) var fossilsData = [FossilData]()
    let headerText = "fossils".localized
    private let subject = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    let failureHandler = PassthroughSubject<Error, Never>()
    var reloadData: AnyPublisher<Void, Never> {
        subject.eraseToAnyPublisher()
    }
    
    init(loader: Loader = CreatureLoader()) {
        self.loader = loader
    }
    
    func loadFossils() {
        loader.loadFossilsData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.failureHandler.send(error)
                }
            } receiveValue: { [weak self] fossils in
                guard let self else { return }
                fossilsData = fossils
                subject.send()
            }
            .store(in: &cancellables)
    }
}
