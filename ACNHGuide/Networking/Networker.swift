//
//  Networker.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation
import Network

final class Networker: Networking {
    
    private let networkPathMonitor: NWPathMonitor
    
    init(networkPathMonitor: NWPathMonitor = .init()) {
        self.networkPathMonitor = networkPathMonitor
        startMonitoringMonitor()
    }
    
    private func startMonitoringMonitor() {
        networkPathMonitor.start(queue: .global())
        networkPathMonitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            self.handleNetworkConnectivityChange(path)
        }
    }
    
    private func handleNetworkConnectivityChange(_ path: NWPath) {
        let isNetworkAvailable = (path.status == .satisfied)
        let notificationName = Notification.Name("NetworkConnectivityDidChange")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["isNetworkAvailable": isNetworkAvailable])
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
    
    func fetchData<T: Decodable>(
        with urlString: String,
        completionHandler: @escaping ((Result<[T], NetworkingError>) -> Void)
    ) {
        
        guard isNetworkAvailable else {
            completionHandler(.failure(.noInternetConnection))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlInvalid))
            return
        }
        
        let urlSession = URLSession(configuration: configuration)
        let request = URLRequest(url: url)
        urlSession.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completionHandler(.failure(.error))
                return
            }
            
            guard let data else {
                completionHandler(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([T].self, from: data)
                completionHandler(.success(decodedData))
                return
            } catch {
                completionHandler(.failure(.decodingFailure))
                return
            }
        }.resume()
    }
}
