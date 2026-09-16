//
//  ACNHAPI.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation

// Points d'accès aux données et aux visuels d'Animal Crossing: New Horizons.
//
// acnhapi.com n'est plus en ligne. Les données proviennent désormais de son dépôt
// d'origine (alexislours/ACNHAPI, archivé, licence MIT).
//
// L'URL est épinglée à un commit plutôt qu'à une branche : le contenu servi est
// immuable, donc le dépôt ne peut pas changer ce que l'app reçoit.
//
// jsDelivr a été écarté : il plafonne un dépôt à 50 Mo et celui-ci en fait 359,
// ce qui lui fait refuser une partie des visuels avec une erreur 403.
enum ACNHAPI {
    
    private static let commit = "6df0d7318a97"
    private static let baseURL = "https://raw.githubusercontent.com/alexislours/ACNHAPI/\(commit)"
    
    enum Category: String {
        case fish, bugs, sea, fossils
    }
    
    // Le dossier v1a sert chaque catégorie sous forme de tableau JSON.
    static func endpoint(for category: Category) -> String {
        "\(baseURL)/v1a/\(category.rawValue).json"
    }
    
    // Copie embarquée servant de repli quand le réseau est indisponible.
    static func bundledFileName(for category: Category) -> String {
        "\(category.rawValue).json"
    }
    
    static func imageURL(for category: Category, fileName: String) -> URL? {
        URL(string: "\(baseURL)/images/\(category.rawValue)/\(assetName(from: fileName)).png")
    }
    
    static func iconURL(for category: Category, fileName: String) -> URL? {
        URL(string: "\(baseURL)/icons/\(category.rawValue)/\(assetName(from: fileName)).png")
    }
    
    // Trois fossiles portent un nom différent dans le JSON et dans le dossier des visuels.
    private static func assetName(from fileName: String) -> String {
        switch fileName {
        case "pachy_skull":
            return "pachysaurus_skull"
        case "pachy_tail":
            return "pachysaurus_tail"
        case "plesio_torso":
            return "plesio_body"
        default:
            return fileName
        }
    }
}
