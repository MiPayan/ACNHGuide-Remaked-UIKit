//
//  CreatureLoader.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation

final class CreatureLoader: CreatureLoaderDelegate {
    
    private let session: Networking
    private let endpoint = "https://acnhapi.com/v1a/"
    
    init(session: Networking = Networker()) {
        self.session = session
    }
    
    func getFishesData(completionHandler: @escaping ((Result<[FishData], NetworkingError>)) -> Void) {
        let urlString = "\(endpoint)fish/"
        session.fetchData(with: urlString) { (result: Result<[FishData], NetworkingError>) in
            switch result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getSeaCreaturesData(completionHandler: @escaping ((Result<[SeaCreatureData], NetworkingError>)) -> Void) {
        let urlString = "\(endpoint)sea/"
        session.fetchData(with: urlString) { (result: Result<[SeaCreatureData], NetworkingError>) in
            switch result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getBugsData(completionHandler: @escaping ((Result<[BugData], NetworkingError>)) -> Void) {
        let urlString = "\(endpoint)bugs/"
        session.fetchData(with: urlString) { (result: Result<[BugData], NetworkingError>) in
            switch result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getFossilsData(completionHandler: @escaping ((Result<[FossilData], NetworkingError>)) -> Void) {
        let urlString = "\(endpoint)fossils/"
        session.fetchData(with: urlString) { (result: Result<[FossilData], NetworkingError>) in
            switch result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
