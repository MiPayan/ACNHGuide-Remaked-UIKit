//
//  Networker.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation

final class Networker: Networking {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchData<T: Decodable>(
        with urlString: String,
        completionHandler: @escaping ((Result<[T], NetworkingError>) -> Void)
    ) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlInvalid))
            return
        }
        
        let request = URLRequest(url: url)
        urlSession.dataTask(with: request) { data, _, error in
            if error != nil {
                completionHandler(.failure(.error))
            }
            
            guard let data else {
                completionHandler(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([T].self, from: data)
                completionHandler(.success(decodedData))
                return
            } catch {
                completionHandler(.failure(.decodingFailure))
                return
            }
        }.resume()
    }
}
