//
//  Networking.swift
//  ACNHS
//
//  Created by Mickael PAYAN on 03/05/2022.
//

import Foundation

final class Networking: NetworkingProtocol {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchData<T: Decodable>(
        with urlString: String,
        completion handler: @escaping ((Result<[T], NetworkingError>) -> Void)
    ) {
        guard let url = URL(string: urlString) else {
            handler(.failure(.urlInvalid))
            return
        }
        
        let request = URLRequest(url: url)
        urlSession.dataTask(with: request) { data, _, error in
            if error != nil {
                handler(.failure(.error))
            }
            
            guard let data else {
                handler(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([T].self, from: data)
                handler(.success(decodedData))
                return
            } catch {
                handler(.failure(.decodingFailure))
                return
            }
        }.resume()
    }
}
