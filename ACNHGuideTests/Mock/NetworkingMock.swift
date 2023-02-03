//
//  NetworkingMock.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 02/02/2023.
//

import XCTest
@testable import ACNHGuide

final class NetworkingMock<T: Decodable>: NetworkingProtocol {
    
    private var responseData: Result<[T], NetworkingError>

     init(responseData: Result<[T], NetworkingError>) {
         self.responseData = responseData
     }
    
    func fetchData<T: Decodable>(with urlString: String, completion handler: @escaping ((Result<[T], NetworkingError>) -> Void)) {
        handler(responseData as! Result<[T], NetworkingError>)
    }
}
