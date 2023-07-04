//
//  CreatureViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 27/06/2023.
//

import Foundation
import Combine

class CreatureViewModel<CreatureData>: ObservableObject {
    
    let loader: Loader
    let currentCalendar: CalendarDelegate
    var creatures = [CreatureData]()
    let subject = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    let failureHandler = PassthroughSubject<Error, Never>()
    var reloadData: AnyPublisher<Void, Never> {
        subject.eraseToAnyPublisher()
    }
    var isShowingNorthCreature: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "Hemisphere")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Hemisphere")
        }
    }
    
    init(
        loader: Loader = CreatureLoader(),
        currentCalendar: CalendarDelegate = CurrentCalendar()
    ) {
        self.loader = loader
        self.currentCalendar = currentCalendar
    }
    
    open func loadCreatures() {
        //        Implement in subclass.
    }
}
