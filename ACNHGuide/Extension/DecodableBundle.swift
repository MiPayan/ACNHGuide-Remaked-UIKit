//
//  DecodableBundle.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 18/01/2023.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle ")
        }
        return decodedData
    }
    
    // Variante tolérante de decode(_:) : le repli hors ligne doit pouvoir échouer
    // sans faire planter l'app, contrairement au chargement des fixtures.
    func decodeIfPresent<T: Decodable>(_ file: String) -> T? {
        guard let url = url(forResource: file, withExtension: nil),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
