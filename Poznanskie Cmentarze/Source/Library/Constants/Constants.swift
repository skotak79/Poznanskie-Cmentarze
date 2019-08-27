//
//  Constants.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 14.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import Foundation

struct Constants {
    static let noData = "0001-01-01"
    static let maxGraves = 100
    static let idForLubowskaCemetery = 3
    static let idForSamotnaCemetery = 12
    static let aboutScreenTitle: String = """
    Poznańskie Cmentarze - wyszukiwarka miejsca pochówku
    Wojciech Skotak (2019)
    """
    // swiftlint:disable line_length
    static let aboutScreenDescription: String = """
    Aplikacja korzysta z danych platformy http://www.poznan.pl/api udostępnianą przez Urząd Miasta Poznania.

    Druga data przy nazwisku jest datą śmierci albo pogrzebu w zależności od dostępnych danych.

    Aby wyszukiwarka uwzględniała cmentarze Samotna i Lubowska należy obowiązkowo podawać imię(imiona) i nazwisko.

    Ikony wykorzystane w aplikacji:
    - 'Info (not found)' by icongeek from the Noun Project,
    - 'Search' by Niklas Bäversten from the Noun Project,
    - 'Graveyard' by Thomas Helbig from the Noun Project,
    - 'Info' by Tom Walsh from the Noun Project,
    - 'Grave' by Nick Novell from the Noun Project (Logo aplikacji)
    """
}
