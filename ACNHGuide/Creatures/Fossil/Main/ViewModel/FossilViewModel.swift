//
//  FossilViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation
import Combine

final class FossilViewModel: CreatureViewModel<FossilData> {

    let headerText = "fossils".localized

    override func loadCreature() {
        loader.loadFossilsData()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    failureHandler.send(error)
                }
            } receiveValue: { [weak self] fossils in
                guard let self else { return }
                creatures = fossils
                subject.send()
            }
            .store(in: &cancellables)
    }
}
