//
//  Availability.swift
//  ACNHS
//
//  Created by Mickael PAYAN on 03/05/2022.
//

import Foundation

struct FishAvailability: Decodable {
    let monthNorthern, monthSouthern, time: String
    let isAllDay, isAllYear: Bool
    let location, rarity: String
    let monthArrayNorthern, monthArraySouthern, timeArray: [Int]
    
    private enum CodingKeys: String, CodingKey {
        case monthNorthern = "month-northern"
        case monthSouthern = "month-southern"
        case time, isAllDay, isAllYear, location, rarity
        case monthArrayNorthern = "month-array-northern"
        case monthArraySouthern = "month-array-southern"
        case timeArray = "time-array"
    }
}
