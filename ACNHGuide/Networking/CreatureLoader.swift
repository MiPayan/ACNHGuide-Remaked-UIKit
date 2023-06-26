//
//  CreatureLoader.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation
import Combine

final class CreatureLoader: Loader {
    
    private let session: Networking
    private let endpoint = "https://acnhapi.com/v1a/"
    
    init(session: Networking = Networker()) {
        self.session = session
    }
    
    func loadFishesData() -> AnyPublisher<[FishData], NetworkingError> {
        let urlString = "\(endpoint)fish/"
        return session.fetchData(with: urlString)
    }
    
    func loadSeaCreaturesData() -> AnyPublisher<[SeaCreatureData], NetworkingError> {
        let urlString = "\(endpoint)sea/"
        return session.fetchData(with: urlString)
    }
    
    func loadBugsData() -> AnyPublisher<[BugData], NetworkingError> {
        let urlString = "\(endpoint)bugs/"
        return session.fetchData(with: urlString)
    }
    
    func loadFossilsData() -> AnyPublisher<[FossilData], NetworkingError> {
        let urlString = "\(endpoint)fossils/"
        return session.fetchData(with: urlString)
    }
    
    func loadCreaturesData() -> AnyPublisher<(fishes: [FishData], seaCreatures: [SeaCreatureData], bugs: [BugData], fossils: [FossilData]), NetworkingError> {
        let fishesPublisher = loadFishesData()
        let seaCreaturesPublisher = loadSeaCreaturesData()
        let bugsPublisher = loadBugsData()
        let fossilsPublisher = loadFossilsData()
        
        return Publishers.Zip4(fishesPublisher, seaCreaturesPublisher, bugsPublisher, fossilsPublisher)
            .flatMap { fishes, seaCreatures, bugs, fossils in
                return Just((fishes, seaCreatures, bugs, fossils))
                    .setFailureType(to: NetworkingError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
