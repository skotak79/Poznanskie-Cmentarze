//
//  Name.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 12.05.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import Foundation

/// convenient struct for dealing with name(s) and surname
struct Name {
    var firstName: String = ""
    var surname: String = ""
    init(firstName: String, surname: String) {
        self.firstName = firstName
        self.surname = surname
    }
}

extension Name {
    /// parsing surnameName
    init(surnameName: String) {
        var names = surnameName.components(separatedBy: " ")
        self.surname = names.removeFirst()
        self.firstName = names.joined(separator: " ")
    }
    init(with query: String) {
        let components = query.split(separator: " ", maxSplits: 2).map(String.init)
        switch components.count {
        case 1:
            firstName = ""
            surname = components.first!.localizedLowercase
        case 2:
            firstName = components.first!.localizedLowercase
            surname = components.last!.localizedLowercase
        default:
            firstName = "\(components[0].localizedLowercase) \(components[1].localizedLowercase)"
            surname = components.last!.localizedLowercase
        }
        debugPrint("Imie \(firstName)")
        debugPrint("Nazwisko \(surname)")
    }
}
