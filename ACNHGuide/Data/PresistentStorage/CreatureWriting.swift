//
//  CreatureWriting.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/07/2023.
//

import Foundation

protocol CreatureWriting {
    func saveCreature(fileName: String, completionHandler: @escaping (Error) -> Void)
    func deleteCreature(fileName: String, completionHandler: @escaping (Error) -> Void)
}
