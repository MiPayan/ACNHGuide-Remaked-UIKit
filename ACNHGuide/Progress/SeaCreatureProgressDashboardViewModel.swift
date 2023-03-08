//
//  SeaCreatureProgressDashboardViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/03/2023.
//

import Foundation

final class SeaCreatureProgressDashboardViewModel {
    
    private let service: Service
    private let mainDispatchQueue: DispatchQueueDelegate
    private(set) var seaCreaturesData = [SeaCreatureData]()
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    
    init(service: Service = ACNHService(), mainDispatchQueue: DispatchQueueDelegate = DispatchQueue.main) {
        self.service = service
        self.mainDispatchQueue = mainDispatchQueue
    }
    
    func getSeaCreaturesData() {
        service.getSeaCreaturesData { [weak self] result in
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
    }
}
