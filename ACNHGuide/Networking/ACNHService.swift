//
//  ACNHService.swift
//  ACNHS
//
//  Created by Mickael PAYAN on 03/05/2022.
//

import Foundation

final class ACNHService: ACNHServiceProtocol {
    
    private let session: NetworkingProtocol
    private let endpoint = "https://acnhapi.com/v1a/"
    
    init(session: NetworkingProtocol = Networking()) {
        self.session = session
    }
    
    func getFishData(completionHandler: @escaping ((Result<[FishData], NetworkingError>)) -> Void) {
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
    
    func getSeaCreatureData(completionHandler: @escaping ((Result<[SeaCreatureData], NetworkingError>)) -> Void) {
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
    
    func getBugData(completionHandler: @escaping ((Result<[BugData], NetworkingError>)) -> Void) {
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
    
    func getFossilData(completionHandler: @escaping ((Result<[FossilData], NetworkingError>)) -> Void) {
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
