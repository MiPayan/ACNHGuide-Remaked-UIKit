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
    
    func fetchData<T>(with urlString: String, completion handler: @escaping ((Result<[T], NetworkingError>) -> Void)) {
        invokedFetchDataCount += 1
        stubbedFetchDataUrlStringParameter = urlString
//        handler(stubbedResult)
    }
}
