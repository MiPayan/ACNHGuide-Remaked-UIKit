//
//  NetworkProtocol.swift
//  ACNHS
//
//  Created by Mickael PAYAN on 16/06/2022.
//

import Foundation

protocol NetworkingProtocol {
    func fetchData<T: Decodable>(
        with urlString: String,
        completion handler: @escaping ((Result<[T], NetworkingError>) -> Void)
    )
}
