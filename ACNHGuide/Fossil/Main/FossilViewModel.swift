//
//  FossilViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import Foundation

final class FossilViewModel {
    
    private let loader: Loader
    private let mainDispatchQueue: DispatchQueueDelegate
    private let currentCalendar: CalendarDelegate
    private(set) var fossilsData = [FossilData]()
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    let headerText = "fossils".localized
    
    init(
        loader: Loader = CreatureLoader(),
        mainDispatchQueue: DispatchQueueDelegate = DispatchQueue.main,
        currentCalendar: CalendarDelegate = CurrentCalendar()
    ) {
        self.loader = loader
        self.mainDispatchQueue = mainDispatchQueue
        self.currentCalendar = currentCalendar
    }
    
    func getFossilsData() {
        loader.loadFossilsData { [weak self] result in
            guard let self else { return }
            mainDispatchQueue.async {
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
