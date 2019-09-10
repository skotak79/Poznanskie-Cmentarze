//
//  GraveViewModel.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 12.05.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import Foundation
import MapKit

struct GraveViewModel {

    private let grave: Grave
    private let cemeteryIdsWithNames: [Int: String]

    init(grave: Grave, cemeteryIdsWithNames: [Int: String]) {
        self.grave = grave
        self.cemeteryIdsWithNames = cemeteryIdsWithNames
    }
}

extension GraveViewModel {

    var nameAndSurname: String {
        return ("\(grave.nameAndSurname.0.capitalized) \( grave.nameAndSurname.1.capitalized)")
    }

    private var tempDate: String {
        return (grave.properties.dateDeath == Values.emptyData) ? grave.properties.dateBurial : grave.properties.dateDeath
    }

    var years: String {
        let birthDate = (grave.properties.dateBirth == Values.emptyData) ? "?" : grave.properties.dateBirth
        let secondDate = (tempDate == Values.emptyData) ? "?" : tempDate

        return ("\(birthDate) - \(secondDate)")
    }

    var fieldQuarterRowPlace: String {
        let positionDetails = [
            (grave.properties.field.isEmpty) ? "" : "Pole: \(grave.properties.field)",
            (grave.properties.quarter.isEmpty) ? "" : "Kwatera: \(grave.properties.quarter)",
            (grave.properties.row.isEmpty) ? "" : "Rząd: \(grave.properties.row)",
            (grave.properties.place.isEmpty) ? "" : "Miejsce: \(grave.properties.place)"
        ]
        return positionDetails.joined(separator: " ").trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var location: CLLocationCoordinate2D? {
        return grave.location
    }

    var cmName: String {
        return "Cmentarz \(cemeteryIdsWithNames[grave.properties.cmId] ?? "?")"
    }
}

extension GraveViewModel: Comparable {

    private var dateToCompare: Date {
        return tempDate.toDate()
    }

    static func == (lhs: GraveViewModel, rhs: GraveViewModel) -> Bool {
        return lhs.dateToCompare == rhs.dateToCompare
    }
    static func < (lhs: GraveViewModel, rhs: GraveViewModel) -> Bool {
        return lhs.dateToCompare < rhs.dateToCompare
    }
    static func > (lhs: GraveViewModel, rhs: GraveViewModel) -> Bool {
        return lhs.dateToCompare > rhs.dateToCompare
    }
}

extension GraveViewModel {

    var attributedTitle: NSAttributedString {
        let font = UIFont.preferredCustomFont(forTextStyle: .headline)
        let titleString = self.nameAndSurname.attributtedString(with: font, foregroundColor: .darkText)

        return titleString
    }
    var attributedSubtitle: NSAttributedString {
        let font = UIFont.preferredCustomFont(forTextStyle: .subheadline)
        let subtitleString = self.years.attributtedString(with: font, foregroundColor: .darkText)

        return subtitleString
    }
}

private enum Values {
    static let emptyData = "0001-01-01"
}
