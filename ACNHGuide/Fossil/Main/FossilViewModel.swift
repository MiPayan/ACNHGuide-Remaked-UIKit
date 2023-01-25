//
//  FossilViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation

final class FossilViewModel {
    
    private let service: ACNHServiceProtocol
    private let mainDispatchQueue: DispatchQueueProtocol
    private let currentCalendar: CalendarProtocol
    private(set) var fossilData = [FossilData]()
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    
    init(
        service: ACNHServiceProtocol = ACNHService(),
        mainDispatchQueue: DispatchQueueProtocol = DispatchQueue.main,
        currentCalendar: CalendarProtocol = CurrentCalendar()
    ) {
        self.service = service
        self.mainDispatchQueue = mainDispatchQueue
        self.currentCalendar = currentCalendar
    }
    
    func getFossilData() {
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
