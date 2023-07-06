//
//  Loader.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation
import Combine

protocol Loader {
    func loadFishesData() -> AnyPublisher<[FishData], NetworkerError>
    func loadSeaCreaturesData() -> AnyPublisher<[SeaCreatureData], NetworkerError>
    func loadBugsData() -> AnyPublisher<[BugData], NetworkerError>
    func loadFossilsData() -> AnyPublisher<[FossilData], NetworkerError>
    func loadCreaturesData() -> AnyPublisher<(fishes: [FishData], seaCreatures: [SeaCreatureData], bugs: [BugData], fossils: [FossilData]), NetworkerError>
}
