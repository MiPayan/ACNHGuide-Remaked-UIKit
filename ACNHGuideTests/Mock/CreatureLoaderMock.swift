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
    var stubbedFishesPublisher: AnyPublisher<[FishData], NetworkerError>!
    
    func loadFishesData() -> AnyPublisher<[FishData], NetworkerError> {
        invokedLoadFishesData += 1
        return stubbedFishesPublisher
            .eraseToAnyPublisher()
    }
    
    var invokedLoadSeaCreaturesData = 0
    var stubbedSeaCreaturesPublisher: AnyPublisher<[SeaCreatureData], NetworkerError>!
    
    func loadSeaCreaturesData() -> AnyPublisher<[SeaCreatureData], NetworkerError> {
        invokedLoadSeaCreaturesData += 1
        return stubbedSeaCreaturesPublisher
            .eraseToAnyPublisher()
    }
    
    var invokedBugsData = 0
    var stubbedBugsPublisher: AnyPublisher<[BugData], NetworkerError>!
    
    func loadBugsData() -> AnyPublisher<[BugData], NetworkerError> {
        invokedBugsData += 1
        return stubbedBugsPublisher
            .eraseToAnyPublisher()
    }
    
    var invokedLoadFossilsData = 0
    var stubbedFossilsPublisher: AnyPublisher<[FossilData], NetworkerError>!
    
    func loadFossilsData() -> AnyPublisher<[FossilData], NetworkerError> {
        invokedLoadFossilsData += 1
        return stubbedFossilsPublisher
            .eraseToAnyPublisher()
    }
    
    var invokedLoadCreaturesData = 0
    var stubbedCreaturesPublisher: AnyPublisher<(fishes: [FishData], seaCreatures: [SeaCreatureData], bugs: [BugData], fossils: [FossilData]), NetworkerError>!
    
    func loadCreaturesData() -> AnyPublisher<(fishes: [FishData], seaCreatures: [SeaCreatureData], bugs: [BugData], fossils: [FossilData]), NetworkerError> {
        invokedLoadCreaturesData += 1
        return stubbedCreaturesPublisher
            .eraseToAnyPublisher()
    }
}
