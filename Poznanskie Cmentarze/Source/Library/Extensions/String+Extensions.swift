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

//    func toDate() -> Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let date = dateFormatter.date(from: self)
//
//        return date!
//    }
//
//        private static let dateSafeCharacters = CharacterSet(charactersIn: "0123456789- ")
//
//        public func convertedToDateSafeFormat() -> String? {
//            if let latin = self.applyingTransform(StringTransform("Any-Latin; Latin-ASCII; Lower;"), reverse: false) {
//                let urlComponents = latin.components(separatedBy: String.dateSafeCharacters.inverted)
//                let result = urlComponents.filter { $0 != "" }.joined(separator: "-")
//
//                if !result.isEmpty {
//                    return result
//                }
//            }
//
//            return nil
//        }
}
