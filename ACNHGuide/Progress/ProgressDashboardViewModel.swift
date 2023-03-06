//
//  ProgressDashboardViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 27/01/2023.
//

import Foundation

final class ProgressDashboardViewModel {
    
    private let service: ACNHServiceProtocol
    private let mainDispatchQueue: DispatchQueueDelegate
    private(set) var fishData = [FishData]()
    private(set) var seaCreaturesData = [SeaCreatureData]()
    private(set) var bugData = [BugData]()
    private(set) var fossilData = [FossilData]()
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    let numberOfRowsInSection = 4
    
    init(service: ACNHServiceProtocol = ACNHService(), mainDispatchQueue: DispatchQueueDelegate = DispatchQueue.main) {
        self.service = service
        self.mainDispatchQueue = mainDispatchQueue
    }
    
    func getDatas() {
        service.getFishData { [weak self] result in
            guard let self else { return }
            self.mainDispatchQueue.async {
                switch result {
                case .success(let fishData):
                    self.fishData = fishData
                    self.successHandler()
                case .failure(_):
                    self.failureHandler()
                }
            }
        }
        
        service.getSeaCreatureData { [weak self] result in
            guard let self else { return }
            self.mainDispatchQueue.async {
                switch result {
                case .success(let seaCreature):
                    self.seaCreaturesData = seaCreature
                    self.successHandler()
                case .failure(_):
                    self.failureHandler()
                }
            }
        }
        
        service.getBugData { [weak self] result in
            guard let self else { return }
            self.mainDispatchQueue.async {
                switch result {
                case .success(let bugData):
                    self.bugData = bugData
                    self.successHandler()
                case .failure(_):
                    self.failureHandler()
                }
            }
        }
        
        service.getFossilData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let fossilData):
                self.mainDispatchQueue.async {
                    self.fossilData = fossilData
                    self.successHandler()
                }
            case .failure(_):
                self.failureHandler()
            }
        }
    }
}
