//
//  FossilViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation

final class FossilViewModel {
    
    private let service: CreatureServicesProtocol
    private let mainDispatchQueue: DispatchQueueDelegate
    private let currentCalendar: CalendarDelegate
    private(set) var fossilsData = [FossilData]()
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    let headerText = "fossils".localized
    
    init(
        service: CreatureServicesProtocol = CreatureService(),
        mainDispatchQueue: DispatchQueueDelegate = DispatchQueue.main,
        currentCalendar: CalendarDelegate = CurrentCalendar()
    ) {
        self.service = service
        self.mainDispatchQueue = mainDispatchQueue
        self.currentCalendar = currentCalendar
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
