//
//  String+Extensions.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 05/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import UIKit
extension String {
    func attributtedString(with font: UIFont, foregroundColor: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: foregroundColor]
        let attributedString = NSMutableAttributedString(string: self, attributes: attributes)

        return attributedString
    }

    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)

        return date!
    }
}
