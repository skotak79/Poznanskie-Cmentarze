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

    var location: CLLocationCoordinate2D? {
        let coordinates = grave.geometry.coordinates.locationCoordinate()
        return coordinates
    }

    var nameAndSurname: String {
        guard [IdsForUniqueCemeteries.lubowska, IdsForUniqueCemeteries.samotna].contains(grave.properties.cmId) else {
            let name = grave.properties.name.isEmpty ? "?" : grave.properties.name
            return "\(name.capitalized) \(grave.properties.surname.capitalized)"
        }
        let localSurnameName = Name(surnameName: grave.properties.surnameName)
        let firstName = localSurnameName.firstName
        let surname = localSurnameName.surname
        return ("\(firstName.capitalized) \(surname.capitalized)")
    }

    // sorting purposes
    var deathOrBurialDate: Date {
        if grave.properties.dateDeath.isValid() {
            return grave.properties.dateDeath
        } else {
            return grave.properties.dateBurial
        }
    }

    var deathOrBurialDateAsStringWithEmojis: String {
        if grave.properties.dateDeath.isValid() {
            return "✝️ \(DateFormatter.default.string(from: grave.properties.dateDeath))"
        } else if grave.properties.dateBurial.isValid() {
            return "⚰️ \(DateFormatter.default.string(from: grave.properties.dateBurial))"
        } else { return "?" }
    }

    var years: String {
        let birthDate = (grave.properties.dateBirth.isValid()) ? "✧ \(DateFormatter.default.string(from: grave.properties.dateBirth))" : "?"
        return ("\(birthDate) - \(deathOrBurialDateAsStringWithEmojis)")
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

    var cmName: String {
        return "Cmentarz \(cemeteryIdsWithNames[grave.properties.cmId] ?? "?")"
    }
}

extension GraveViewModel: Comparable {

    static func == (lhs: GraveViewModel, rhs: GraveViewModel) -> Bool {
        return lhs.deathOrBurialDate == rhs.deathOrBurialDate
    }
    static func < (lhs: GraveViewModel, rhs: GraveViewModel) -> Bool {
        return lhs.deathOrBurialDate < rhs.deathOrBurialDate
    }
    static func > (lhs: GraveViewModel, rhs: GraveViewModel) -> Bool {
        return lhs.deathOrBurialDate > rhs.deathOrBurialDate
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
