//
//  Loader.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation
import RxSwift

protocol Loader {
    func getFishesData() -> Observable<Result<[FishData], NetworkingError>>
    func getSeaCreaturesData() -> Observable<Result<[SeaCreatureData], NetworkingError>>
    func getBugsData() -> Observable<Result<[BugData], NetworkingError>>
    func getFossilsData() -> Observable<Result<[FossilData], NetworkingError>>
}
