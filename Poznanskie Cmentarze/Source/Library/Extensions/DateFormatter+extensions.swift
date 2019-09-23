//
//  DateFormatter+extensions.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 16/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import Foundation
extension DateFormatter {
    static let `default`: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }()
}
