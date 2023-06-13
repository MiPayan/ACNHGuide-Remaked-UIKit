//
//  Networking.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation
import RxSwift

protocol Networking {
    func fetchData<T: Decodable>(with urlString: String) -> Observable<Result<[T], NetworkingError>>
}
