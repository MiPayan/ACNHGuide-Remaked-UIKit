//
//  Loader.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation
import Combine

protocol Loader {
    func loadFishesData() -> AnyPublisher<[FishData], NetworkingError>
    func loadSeaCreaturesData() -> AnyPublisher<[SeaCreatureData], NetworkingError>
    func loadBugsData() -> AnyPublisher<[BugData], NetworkingError>
    func loadFossilsData() -> AnyPublisher<[FossilData], NetworkingError>
    func loadCreaturesData() -> AnyPublisher<(fishes: [FishData], seaCreatures: [SeaCreatureData], bugs: [BugData], fossils: [FossilData]), NetworkingError>
}
