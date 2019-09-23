//
//  Date+isValid.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 16/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import Foundation
extension Date {
    func isValid() -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!

        let invalidDateComponents = DateComponents(calendar: calendar, year: 0001, month: 1, day: 1)
        let invalidDate = calendar.date(from: invalidDateComponents)
        return (self != invalidDate)
    }
}
