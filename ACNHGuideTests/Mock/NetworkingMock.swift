//
//  NetworkingMock.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 07/03/2023.
//

@testable import ACNHGuide

final class NetworkingMock<T>: Networking {
    
    var stubbedResult: Result<[T], NetworkingError>!
    var invokedFetchDataCount = 0
    var stubbedFetchDataUrlStringParameter: String!
    
    func fetchData<T: Decodable>(with urlString: String, completionHandler: @escaping ((Result<[T], NetworkingError>) -> Void)) {
        invokedFetchDataCount += 1
        stubbedFetchDataUrlStringParameter = urlString
        guard let stubbedResult = stubbedResult as? Result<[T], NetworkingError> else { return }
        completionHandler(stubbedResult)
    }
}
