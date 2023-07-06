//
//  NetworkingMock.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 07/03/2023.
//

@testable import ACNHGuide
import Combine

final class NetworkingMock: Networking {
    
    var invokedFetchDataCount = 0
    var stubbedFetchDataUrlStringParameter: String!
    var stubbedFishData: AnyPublisher<[FishData], NetworkerError>!
    var stubbedSeaCreatureData: AnyPublisher<[SeaCreatureData], NetworkerError>!
    var stubbedBugData: AnyPublisher<[BugData], NetworkerError>!
    var stubbedFossilData: AnyPublisher<[FossilData], NetworkerError>!
    
    func fetchData<T: Decodable>(with urlString: String) -> AnyPublisher<[T], NetworkerError> {
        invokedFetchDataCount += 1
        stubbedFetchDataUrlStringParameter = urlString
        
        if let fishData = stubbedFishData as? AnyPublisher<[T], NetworkerError>, T.self == FishData.self {
            return fishData
        } else if let seaCreatureData = stubbedSeaCreatureData as? AnyPublisher<[T], NetworkerError>, T.self == SeaCreatureData.self {
            return seaCreatureData
        } else if let bugData = stubbedBugData as? AnyPublisher<[T], NetworkerError>, T.self == BugData.self {
            return bugData
        } else if let fossilData = stubbedFossilData as? AnyPublisher<[T], NetworkerError>, T.self == FossilData.self {
            return fossilData
        } else {
            return Fail(error: NetworkerError.decodingFailure).eraseToAnyPublisher()
        }
    }
}
