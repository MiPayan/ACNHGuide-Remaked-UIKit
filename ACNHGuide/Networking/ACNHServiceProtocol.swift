//
//  ACNHServiceProtocol.swift
//  ACNHS
//
//  Created by Mickael PAYAN on 16/06/2022.
//

import Foundation

protocol ACNHServiceProtocol {
    func getFishData(completionHandler: @escaping ((Result<[FishData], NetworkingError>)) -> Void)
    func getSeaCreatureData(completionHandler: @escaping ((Result<[SeaCreatureData], NetworkingError>)) -> Void)
    func getBugData(completionHandler: @escaping ((Result<[BugData], NetworkingError>)) -> Void)
    func getFossilData(completionHandler: @escaping ((Result<[FossilData], NetworkingError>)) -> Void)
}
