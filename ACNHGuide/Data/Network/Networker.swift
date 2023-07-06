//
//  Networker.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation
import Combine
import Network

final class Networker: Networking {
    
    private var configuration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.allowsConstrainedNetworkAccess = true
        return configuration
    }
    
    func fetchData<T: Decodable>(with urlString: String) -> AnyPublisher<[T], NetworkerError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkerError.urlInvalid).eraseToAnyPublisher()
        }
        
        let session = URLSession(configuration: configuration)
        let decoder = JSONDecoder()
        
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                return data
            }
            .decode(type: [T].self, decoder: decoder)
            .mapError { error in
                NetworkerError.decodingFailure
            }
            .eraseToAnyPublisher()
    }
}
