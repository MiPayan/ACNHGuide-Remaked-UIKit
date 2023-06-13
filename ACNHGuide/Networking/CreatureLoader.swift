//
//  CreatureLoader.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation
import RxSwift

final class CreatureLoader: Loader {
    
    private let session: Networking
    private let endpoint = "https://acnhapi.com/v1a/"
    
    init(session: Networking = Networker()) {
        self.session = session
    }
    
    func getFishesData() -> Observable<Result<[FishData], NetworkingError>> {
        let urlString = "\(endpoint)fish"
        return session.fetchData(with: urlString)
    }
    
    func getSeaCreaturesData() -> Observable<Result<[SeaCreatureData], NetworkingError>> {
        let urlString = "\(endpoint)sea"
        return session.fetchData(with: urlString)
    }
    
    func getBugsData() -> Observable<Result<[BugData], NetworkingError>> {
        let urlString = "\(endpoint)bugs"
        return session.fetchData(with: urlString)
    }
    
    func getFossilsData() -> Observable<Result<[FossilData], NetworkingError>> {
        let urlString = "\(endpoint)fossils"
        return session.fetchData(with: urlString)
    }
}
