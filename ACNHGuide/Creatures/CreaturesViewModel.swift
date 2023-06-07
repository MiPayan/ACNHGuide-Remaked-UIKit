//
//  CreaturesViewModel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 07/06/2023.
//

import Foundation


final class CreaturesViewModel {
    
    private let service: CreatureLoaderDelegate
    private(set) var fishesData = [FishData]()
    private var seaCreaturesData = [SeaCreatureData]()
    private var bugsData = [BugData]()
    private var fossilsData = [FossilData]()
    let headerSection = "Creatures"
    let numberOfSections = 1
    let numberOfRowsInSection = 1
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    
    init(service: CreatureLoaderDelegate = CreatureLoader()) {
        self.service = service
    }
    
    func getCreatures() {
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
        
//        group.enter()
//        service.getSeaCreaturesData { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let seaCreatures):
//                self.seaCreaturesData = seaCreatures
//                group.leave()
//            case .failure(_):
//                group.leave()
//            }
//        }
//
//        group.enter()
//        service.getBugsData { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let bugsData):
//                self.bugsData = bugsData
//                group.leave()
//            case .failure(_):
//                group.leave()
//            }
//        }
//
//        group.enter()
//        service.getFossilsData { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let fossilsData):
//                self.fossilsData = fossilsData
//                group.leave()
//            case .failure(_):
//                group.leave()
//            }
//        }
        
//        group.notify(queue: .main) { [weak self] in
//            guard let self else { return }
//            guard !fishesData.isEmpty && !seaCreaturesData.isEmpty && !bugsData.isEmpty && !fossilsData.isEmpty else {
//                return failureHandler()
//            }
//            successHandler()
//        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            guard !fishesData.isEmpty else {
                return failureHandler()
            }
            successHandler()
        }
    }
}
