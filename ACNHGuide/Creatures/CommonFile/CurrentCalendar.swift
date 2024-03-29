//
//  CurrentCalendar.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 10/01/2023.
//

import Foundation

protocol ReloadDataDelegate: AnyObject {
    func reloadData()
}

protocol CalendarDelegate {
    var currentDate: (Int, Int) { get }
}

final class CurrentCalendar: CalendarDelegate {
    
    var currentDate: (Int, Int) {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let month = calendar.component(.month, from: date)
        return (hour, month)
    }
}
