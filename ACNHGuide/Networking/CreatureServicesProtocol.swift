//
//  CreatureServicesProtocol.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation

protocol CreatureServicesProtocol {
    func getFishesData(completionHandler: @escaping ((Result<[FishData], NetworkingError>)) -> Void)
    func getSeaCreaturesData(completionHandler: @escaping ((Result<[SeaCreatureData], NetworkingError>)) -> Void)
    func getBugsData(completionHandler: @escaping ((Result<[BugData], NetworkingError>)) -> Void)
    func getFossilsData(completionHandler: @escaping ((Result<[FossilData], NetworkingError>)) -> Void)
}
