//
//  NormalizingDecoder.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 15/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import Foundation

//class NormalizingDecoder: JSONDecoder {
//
//    /// The formatter for date strings returned by `poznan.pl`.
//    let dateFormatter = DateFormatter()
//    let calendar = Calendar.current
//
//    override init() {
//        super.init()
//        //dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        //dateFormatter.timeStyle = .medium
//        //keyDecodingStrategy = .convertFromSnakeCase
//        dateDecodingStrategy = .custom { (decoder) -> Date in
//            let container = try decoder.singleValueContainer()
//            let dateString = try container.decode(String.self)
//            let date = self.dateFormatter.date(from: dateString)
//
//            if let date = date {
//                let midnightThen = self.calendar.startOfDay(for: date)
//                let millisecondsFromMidnight = date.timeIntervalSince(midnightThen)
//
//                let today = Date()
//                let midnightToday = self.calendar.startOfDay(for: today)
//                let normalizedDate = midnightToday.addingTimeInterval(millisecondsFromMidnight)
//                return normalizedDate
//            } else {
//                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Date values must be formatted like 2019-01-01")
//            }
//        }
//    }
//}
//extension DateFormatter {
//    static let `default`: DateFormatter = {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//        return dateFormatter
//    }()
//}
