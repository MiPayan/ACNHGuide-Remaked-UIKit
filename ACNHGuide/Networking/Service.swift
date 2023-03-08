//
//  Service.swift
//  ACNHS
//
//  Created by Mickael PAYAN on 16/06/2022.
//

import Foundation

protocol Service {
    func getFishesData(completionHandler: @escaping ((Result<[FishData], NetworkingError>)) -> Void)
    func getSeaCreaturesData(completionHandler: @escaping ((Result<[SeaCreatureData], NetworkingError>)) -> Void)
    func getBugsData(completionHandler: @escaping ((Result<[BugData], NetworkingError>)) -> Void)
    func getFossilsData(completionHandler: @escaping ((Result<[FossilData], NetworkingError>)) -> Void)
}
