//
//  FossilProgressDashboardViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/03/2023.
//

import Foundation

final class FossilProgressDashboardViewModel {
    
    private let service: Service
    private let mainDispatchQueue: DispatchQueueDelegate
    private(set) var fossilsData = [FossilData]()
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    
    init(service: Service = ACNHService(), mainDispatchQueue: DispatchQueueDelegate = DispatchQueue.main) {
        self.service = service
        self.mainDispatchQueue = mainDispatchQueue
    }
    
    func getFossilsData() {
        service.getFossilsData { [weak self] result in
            guard let self else { return }
            self.mainDispatchQueue.async {
                switch result {
                case .success(let fossilData):
                    self.fossilsData = fossilData
                    self.successHandler()
                case .failure(_):
                    self.failureHandler()
                }
            }
        }
    }
}

