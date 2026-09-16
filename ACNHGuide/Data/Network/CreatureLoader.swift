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
    private let bundle: Bundle
    
    init(session: Networking = Networker(), bundle: Bundle = .main) {
        self.session = session
        self.bundle = bundle
    }
    
    func loadFishesData() -> AnyPublisher<[FishData], NetworkingError> {
        loadCreature(.fish)
    }
    
    func loadSeaCreaturesData() -> AnyPublisher<[SeaCreatureData], NetworkingError> {
        loadCreature(.sea)
    }
    
    func loadBugsData() -> AnyPublisher<[BugData], NetworkingError> {
        loadCreature(.bugs)
    }
    
    func loadFossilsData() -> AnyPublisher<[FossilData], NetworkingError> {
        loadCreature(.fossils)
    }
    
    func loadCreaturesData() -> AnyPublisher<(fishes: [FishData], seaCreatures: [SeaCreatureData], bugs: [BugData], fossils: [FossilData]), NetworkingError> {
        Publishers.Zip4(
            loadFishesData(),
            loadSeaCreaturesData(),
            loadBugsData(),
            loadFossilsData()
        )
        .map { fishes, seaCreatures, bugs, fossils in
            (fishes: fishes, seaCreatures: seaCreatures, bugs: bugs, fossils: fossils)
        }
        .eraseToAnyPublisher()
    }
}

private extension CreatureLoader {
    
    // Quand le réseau échoue, on repart sur la copie embarquée plutôt que d'afficher
    // un écran vide : seuls les visuels, eux, restent indisponibles hors ligne.
    // L'erreur d'origine est propagée si cette copie est absente ou illisible.
    func loadCreature<T: Decodable>(_ category: ACNHAPI.Category) -> AnyPublisher<[T], NetworkingError> {
        session.fetchData(with: ACNHAPI.endpoint(for: category))
            .catch { [bundle] error -> AnyPublisher<[T], NetworkingError> in
                guard let bundledCreatures: [T] = bundle.decodeIfPresent(ACNHAPI.bundledFileName(for: category)) else {
                    return Fail(error: error).eraseToAnyPublisher()
                }
                return Just(bundledCreatures)
                    .setFailureType(to: NetworkingError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
