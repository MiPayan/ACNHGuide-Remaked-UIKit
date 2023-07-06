//
//  Networking.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation
import Combine

protocol Networking {
    func fetchData<T: Decodable>(with urlString: String) -> AnyPublisher<[T], NetworkerError>
}
