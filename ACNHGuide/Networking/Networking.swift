//
//  Networking.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation

protocol Networking {
    func fetchData<T: Decodable>(
        with urlString: String,
        completionHandler: @escaping ((Result<[T], NetworkingError>) -> Void)
    )
}
