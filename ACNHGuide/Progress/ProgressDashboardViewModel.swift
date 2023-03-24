//
//  ProgressDashboardViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 27/01/2023.
//

import Foundation
import Dispatch

final class ProgressDashboardViewModel {
    
    private let service: Service
    private(set) var fishesData = [FishData]()
    private(set) var seaCreaturesData = [SeaCreatureData]()
    private(set) var bugsData = [BugData]()
    private(set) var fossilsData = [FossilData]()
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    let numberOfRowsInSection = 4
    
    init(service: Service = ACNHService()) {
        self.service = service
    }
    
    func getDatas() {
        let group = DispatchGroup()
        group.enter()
        service.getFishesData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let fishesData):
                self.fishesData = fishesData
                group.leave()
            case .failure(_):
                group.leave()
            }
        }
        
        group.enter()
        service.getSeaCreaturesData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let seaCreatures):
                self.seaCreaturesData = seaCreatures
                group.leave()
            case .failure(_):
                group.leave()
            }
        }
        
        group.enter()
        service.getBugsData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let bugsData):
                self.bugsData = bugsData
                group.leave()
            case .failure(_):
                group.leave()
            }
        }
        
        group.enter()
        service.getFossilsData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let fossilsData):
                self.fossilsData = fossilsData
                group.leave()
            case .failure(_):
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if !self.fishesData.isEmpty && !self.seaCreaturesData.isEmpty && !self.bugsData.isEmpty && !self.fossilsData.isEmpty {
                self.successHandler()
            } else {
                self.failureHandler()
            }
        }
    }
}
