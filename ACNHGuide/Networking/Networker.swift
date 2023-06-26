//
//  Networker.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation
import Combine
import Network

final class Networker {
    
    private let networkPathMonitor = NWPathMonitor()
    private let queue = DispatchQueue.main
    
    init() {
        startMonitoringMonitor()
    }
    
    private var isNetworkAvailable: Bool {
        networkPathMonitor.currentPath.status == .satisfied ? true : false
    }
    
    private var configuration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.allowsConstrainedNetworkAccess = true
        return configuration
    }
    
    private func startMonitoringMonitor() {
        networkPathMonitor.start(queue: queue)
        networkPathMonitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            handleNetworkConnectivityChange(path)
        }
    }
    
    private func handleNetworkConnectivityChange(_ path: NWPath) {
        let isNetworkAvailable = (path.status == .satisfied)
        let notificationName = Notification.Name("NetworkConnectivityDidChange")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["isNetworkAvailable": isNetworkAvailable])
    }
}

extension Networker: Networking {
    
    func fetchData<T: Decodable>(with urlString: String) -> AnyPublisher<[T], NetworkingError> {
        
        guard isNetworkAvailable else {
            return Fail(error: NetworkingError.noInternetConnection).eraseToAnyPublisher()
        }
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkingError.urlInvalid).eraseToAnyPublisher()
        }
        
        let session = URLSession(configuration: configuration)
        let decoder = JSONDecoder()
        
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                return data
            }
            .decode(type: [T].self, decoder: decoder)
            .mapError { error in
                NetworkingError.decodingFailure
            }
            .eraseToAnyPublisher()
    }
}
