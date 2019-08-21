//
//  GraveViewModel.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 12.05.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import Foundation
import MapKit

/// Or should I just add this as an extension of Grave model?
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
        guard grave.cmId == Constants.idForLubowskaCemetery || grave.cmId == Constants.idForSamotnaCemetery else {
            return "\(grave.name.isEmpty ? "?" : grave.name.capitalized) \(grave.surname.capitalized)"
        }
        return "\(Name(surnameName: grave.surnameName).firstName.capitalized)  \(Name(surnameName: grave.surnameName).surname.capitalized)"
    }
    private var tempDate: String {
        return (grave.dateDeath == Constants.noData) ? grave.dateBurial : grave.dateDeath
    }

    /// for sorting purposes - death or burial date
    var dateToCompare: Date {
        return Helper.date(from: tempDate)
    }
    var dates: (String, String) {
        let birthDate = (grave.dateBirth == Constants.noData) ? "?" : grave.dateBirth
        let secondDate = (tempDate == Constants.noData) ? "?" : tempDate
        return (birthDate, secondDate)
    }
    var years: String {
        return "\(dates.0) - \(dates.1)"
    }
    var fieldQuarterRowPlace: String {
        let positionDetails = [
            (grave.field.isEmpty) ? "" : "Pole: \(grave.field)",
            (grave.quarter.isEmpty) ? "" : "Kwatera: \(grave.quarter)",
            (grave.row.isEmpty) ? "" : "Rząd: \(grave.row)",
            (grave.place.isEmpty) ? "" : "Miejsce: \(grave.place)"
        ]
        return positionDetails.joined(separator: " ").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var cmId: Int {
        return grave.cmId
    }
    var location: CLLocationCoordinate2D? {
        return grave.coordinates.isEmpty ? nil :  CLLocationCoordinate2D(latitude: grave.coordinates[1], longitude: grave.coordinates[0])
    }
    var cmName: String {
        return "Cmentarz \(cemeteryIdsWithNames[grave.cmId] ?? "?")"
    }
}

extension GraveViewModel: Comparable {
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
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredCustomFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.darkText]
        let titleString = NSMutableAttributedString(string: self.nameAndSurname, attributes: titleAttributes)
        
        return titleString
    }
    var attributedSubtitle: NSAttributedString {
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredCustomFont(forTextStyle: .subheadline), NSAttributedString.Key.foregroundColor: UIColor.darkText]
        let subtitleString = NSMutableAttributedString(string: self.years, attributes: subtitleAttributes)

        return subtitleString
    }
}
