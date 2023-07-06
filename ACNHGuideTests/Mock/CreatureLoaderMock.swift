//
//  CreatureLoaderMock.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

@testable import ACNHGuide
import Combine

final class CreatureLoaderMock: Loader {
    
    var invokedLoadFishesData = 0
    var stubbedFishesPublisher: AnyPublisher<[FishData], NetworkingError>!
    
    func loadFishesData() -> AnyPublisher<[FishData], NetworkingError> {
        invokedLoadFishesData += 1
        return stubbedFishesPublisher
            .eraseToAnyPublisher()
    }
    
    var invokedLoadSeaCreaturesData = 0
    var stubbedSeaCreaturesPublisher: AnyPublisher<[SeaCreatureData], NetworkingError>!
    
    func loadSeaCreaturesData() -> AnyPublisher<[SeaCreatureData], NetworkingError> {
        invokedLoadSeaCreaturesData += 1
        return stubbedSeaCreaturesPublisher
            .eraseToAnyPublisher()
    }
    
    var invokedBugsData = 0
    var stubbedBugsPublisher: AnyPublisher<[BugData], NetworkingError>!
    
    func loadBugsData() -> AnyPublisher<[BugData], NetworkingError> {
        invokedBugsData += 1
        return stubbedBugsPublisher
            .eraseToAnyPublisher()
    }
    
    var invokedLoadFossilsData = 0
    var stubbedFossilsPublisher: AnyPublisher<[FossilData], NetworkingError>!
    
    func loadFossilsData() -> AnyPublisher<[FossilData], NetworkingError> {
        invokedLoadFossilsData += 1
        return stubbedFossilsPublisher
            .eraseToAnyPublisher()
    }
    
    var invokedLoadCreaturesData = 0
    var stubbedCreaturesPublisher: AnyPublisher<(fishes: [FishData], seaCreatures: [SeaCreatureData], bugs: [BugData], fossils: [FossilData]), NetworkingError>!
    
    func loadCreaturesData() -> AnyPublisher<(fishes: [FishData], seaCreatures: [SeaCreatureData], bugs: [BugData], fossils: [FossilData]), NetworkingError> {
        invokedLoadCreaturesData += 1
        return stubbedCreaturesPublisher
            .eraseToAnyPublisher()
    }
}
