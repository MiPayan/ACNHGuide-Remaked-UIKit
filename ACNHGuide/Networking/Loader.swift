//
//  Loader.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation

protocol Loader {
    func loadFishesData(completionHandler: @escaping ((Result<[FishData], NetworkingError>)) -> Void)
    func loadSeaCreaturesData(completionHandler: @escaping ((Result<[SeaCreatureData], NetworkingError>)) -> Void)
    func loadBugsData(completionHandler: @escaping ((Result<[BugData], NetworkingError>)) -> Void)
    func loadFossilsData(completionHandler: @escaping ((Result<[FossilData], NetworkingError>)) -> Void)
}
