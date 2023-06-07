//
//  CreatureServicesMock.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

@testable import ACNHGuide

final class CreatureServicesMock: CreatureLoaderDelegate {

    var invokedGetFishesCount = 0
    var stubbedFishResult: Result<[FishData], NetworkingError>!
    
    func getFishesData(completionHandler: @escaping ((Result<[FishData], NetworkingError>)) -> Void) {
        invokedGetFishesCount += 1
        completionHandler(stubbedFishResult)
    }
    
    var invokedGetSeaCreaturesCount = 0
    var stubbedSeaCreatureResult: Result<[SeaCreatureData], NetworkingError>!
    
    func getSeaCreaturesData(completionHandler: @escaping ((Result<[SeaCreatureData], NetworkingError>)) -> Void) {
        invokedGetSeaCreaturesCount += 1
        completionHandler(stubbedSeaCreatureResult)
    }
    
    var invokedGetBugsCount = 0
    var stubbedBugResult: Result<[BugData], NetworkingError>!
    
    func getBugsData(completionHandler: @escaping ((Result<[BugData], NetworkingError>)) -> Void) {
        invokedGetBugsCount += 1
        completionHandler(stubbedBugResult)
    }
    
    var invokedGetFossilsCount = 0
    var stubbedFossilResult: Result<[FossilData], NetworkingError>!
    
    func getFossilsData(completionHandler: @escaping ((Result<[FossilData], NetworkingError>)) -> Void) {
        invokedGetFossilsCount += 1
        completionHandler(stubbedFossilResult)
    }
}
