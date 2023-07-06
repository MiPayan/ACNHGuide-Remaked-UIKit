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
    var stubbedFishData: AnyPublisher<[FishData], NetworkingError>!
    var stubbedSeaCreatureData: AnyPublisher<[SeaCreatureData], NetworkingError>!
    var stubbedBugData: AnyPublisher<[BugData], NetworkingError>!
    var stubbedFossilData: AnyPublisher<[FossilData], NetworkingError>!
    
    func fetchData<T: Decodable>(with urlString: String) -> AnyPublisher<[T], NetworkingError> {
        invokedFetchDataCount += 1
        stubbedFetchDataUrlStringParameter = urlString
        
        if let fishData = stubbedFishData as? AnyPublisher<[T], NetworkingError>, T.self == FishData.self {
            return fishData
        } else if let seaCreatureData = stubbedSeaCreatureData as? AnyPublisher<[T], NetworkingError>, T.self == SeaCreatureData.self {
            return seaCreatureData
        } else if let bugData = stubbedBugData as? AnyPublisher<[T], NetworkingError>, T.self == BugData.self {
            return bugData
        } else if let fossilData = stubbedFossilData as? AnyPublisher<[T], NetworkingError>, T.self == FossilData.self {
            return fossilData
        } else {
            return Fail(error: NetworkingError.decodingFailure).eraseToAnyPublisher()
        }
    }
}
