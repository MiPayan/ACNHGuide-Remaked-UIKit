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
    private let subject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    let headerText = "fossils".localized
    
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
                case .failure(_):
                    print("Is failed.")
                }
            } receiveValue: { [weak self] fossils in
                guard let self else { return }
                fossilsData = fossils
                subject.send()
            }
            .store(in: &cancellables)
    }
}
