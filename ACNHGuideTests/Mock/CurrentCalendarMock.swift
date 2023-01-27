//
//  CurrentCalendarMock.swift
//  ACNHGuideTests
//
//  Created by Mickael PAYAN on 19/01/2023.
//

import XCTest
@testable import ACNHGuide

final class CurrentCalendarMock: CalendarDelegate {
    
    var invockedMakeCurrentCalendarCount = 0
    var stubbedMakeCurrentCalendar: (Int, Int)!
    
    func makeCurrentCalendar() -> (Int, Int) {
        invockedMakeCurrentCalendarCount += 1
       return stubbedMakeCurrentCalendar
    }
}
