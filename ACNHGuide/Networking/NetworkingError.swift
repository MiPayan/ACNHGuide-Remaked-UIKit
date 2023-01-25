//
//  HandleError.swift
//  ACNHS
//
//  Created by Mickael PAYAN on 03/05/2022.
//

import Foundation

enum NetworkingError: Error {
    case urlInvalid
    case noData
    case decodingFailure
    case error
}
