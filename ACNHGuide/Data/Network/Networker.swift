//
//  Networker.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation
import Combine

final class Networker: Networking {
    
    private let session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.allowsConstrainedNetworkAccess = true
        session = URLSession(configuration: configuration)
    }
    
    func fetchData<T: Decodable>(with urlString: String) -> AnyPublisher<[T], NetworkingError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkingError.urlInvalid).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                // Sans ce contrôle, une page d'erreur du serveur est transmise au
                // décodeur et l'échec est signalé comme un problème de décodage.
                guard let httpResponse = response as? HTTPURLResponse else { return data }
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkingError.requestFailed(statusCode: httpResponse.statusCode)
                }
                return data
            }
            .decode(type: [T].self, decoder: decoder)
            .mapError { error in
                switch error {
                case let networkingError as NetworkingError:
                    return networkingError
                case is URLError:
                    return .unreachable
                default:
                    return .decodingFailure
                }
            }
            .eraseToAnyPublisher()
    }
}
