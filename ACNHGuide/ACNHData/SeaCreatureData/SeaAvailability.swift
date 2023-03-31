//
//  SeaAvailability.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation

struct SeaAvailability: Decodable {
    let monthNorthern, monthSouthern, time: String
    let isAllDay, isAllYear: Bool
    let monthArrayNorthern, monthArraySouthern, timeArray: [Int]
    
    private enum CodingKeys: String, CodingKey {
        case monthNorthern = "month-northern"
        case monthSouthern = "month-southern"
        case time, isAllDay, isAllYear
        case monthArrayNorthern = "month-array-northern"
        case monthArraySouthern = "month-array-southern"
        case timeArray = "time-array"
    }
}
