//
//  Networker.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation
import RxSwift

final class Networker: Networking {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchData<T: Decodable>(with urlString: String) -> Observable<Result<[T], NetworkingError>> {
        return Observable.create { observer in
            guard let url = URL(string: urlString) else {
                observer.onNext(.failure(.urlInvalid))
                observer.onCompleted()
                return Disposables.create()
            }
            
            let request = URLRequest(url: url)
            let task = self.urlSession.dataTask(with: request) { data, _, error in
                if error != nil {
                    observer.onNext(.failure(.error))
                    observer.onCompleted()
                    return
                }
                
                guard let data else {
                    observer.onNext(.failure(.noData))
                    observer.onCompleted()
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode([T].self, from: data)
                    observer.onNext(.success(decodedData))
                    observer.onCompleted()
                } catch {
                    observer.onNext(.failure(.decodingFailure))
                    observer.onCompleted()
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
