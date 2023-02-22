//
//  FishService.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 15/02/2023.
//

import Foundation
import RealmSwift

final class CreatureService {
    
    private let creatures: Creatures
    
    init(creatures: Creatures) {
        self.creatures = creatures
    }
}

extension CreatureService: CreaturePeeking {
    
    func isCreatureAlreadySaved(fileName: String) -> Bool {
        switch creatures {
        case .fishes:
            let fish = RealmManager.shared.realm.objects(Fish.self).filter("fileName == %@", fileName).first
            return fish != nil
        case .seaCreatures:
            let seaCreature = RealmManager.shared.realm.objects(SeaCreature.self).filter("fileName == %@", fileName).first
            return seaCreature != nil
        case .bugs:
            let bug = RealmManager.shared.realm.objects(Bug.self).filter("fileName == %@", fileName).first
            return bug != nil
        case .fossils:
            let fossil = RealmManager.shared.realm.objects(Fossil.self).filter("fileName == %@", fileName).first
            return fossil != nil
        }
    }
}

extension CreatureService: CreatureWriting {
    
    func saveCreature(fileName: String) {
        switch creatures {
        case .fishes:
            let fish = Fish()
            fish.fileName = fileName
            RealmManager.shared.saveObject(with: fish)
        case .seaCreatures:
            let seaCreature = SeaCreature()
            seaCreature.fileName = fileName
            RealmManager.shared.saveObject(with: seaCreature)
        case .bugs:
            let bug = Bug()
            bug.fileName = fileName
            RealmManager.shared.saveObject(with: bug)
        case .fossils:
            let fossil = Fossil()
            fossil.fileName = fileName
            RealmManager.shared.saveObject(with: fossil)
        }
    }
    
    func deleteCreature(fileName: String) {
        switch creatures {
        case .fishes:
            if let fish = RealmManager.shared.realm.objects(Fish.self).filter("fileName == %@", fileName).first {
                RealmManager.shared.deleteObject(with: fish)
            }
        case .seaCreatures:
            if let seaCreature = RealmManager.shared.realm.objects(SeaCreature.self).filter("fileName == %@", fileName).first {
                RealmManager.shared.deleteObject(with: seaCreature)
            }
        case .bugs:
            if let bug = RealmManager.shared.realm.objects(Bug.self).filter("fileName == %@", fileName).first {
                RealmManager.shared.deleteObject(with: bug)
            }
        case .fossils:
            if let fossil = RealmManager.shared.realm.objects(Fossil.self).filter("fileName == %@", fileName).first {
                RealmManager.shared.deleteObject(with: fossil)
            }
        }
    }
}

//final class FishService: CreaturePeeking {
//    
//    func isCreatureAlreadySaved(fileName: String) -> Bool {
//        let fish = RealmManager.shared.realm.objects(Fish.self).filter("fileName == %@", fileName).first
//        return fish != nil
//    }
//}
//
//extension FishService: CreatureWriting {
//    
//    func saveCreature(fileName: String) {
//        let fish = Fish()
//        fish.fileName = fileName
//        RealmManager.shared.saveObject(with: fish)
//    }
//    
//    func deleteCreature(fileName: String) {
//        if let fish = RealmManager.shared.realm.objects(Fish.self).filter("fileName == %@", fileName).first {
//            RealmManager.shared.deleteObject(with: fish)
//        }
//    }
//}
