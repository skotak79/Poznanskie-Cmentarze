//
//  AboutView.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 22.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

final class AboutView: UIView {

    private let scrollableView = ScrollableView()
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.darkText
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)

        return label
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        
        return view
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.darkText
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)

        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Setup
    
    private func setup() {
        titleLabel.text = Info.aboutScreenTitle
        contentLabel.text = Info.aboutScreenDescription
        addSubview(scrollableView)
        NSLayoutConstraint.pinToSafeAreas(view: scrollableView, toEdgesOf: self)
        scrollableView.setup(pairs: [
            ScrollableView.Pair(view: titleLabel, inset: UIEdgeInsets(top: 8, left: 15, bottom: 0, right: 15)),
            ScrollableView.Pair(view: separator, inset: UIEdgeInsets(top: 16, left: 15, bottom: 0, right: 15)),
            ScrollableView.Pair(view: contentLabel, inset: UIEdgeInsets(top: 16, left: 15, bottom: 0, right: 15))
            ])
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 0.5)
            ])
    }
}

private enum Info {
    static let aboutScreenTitle: String = """
    Poznańskie Cmentarze - wyszukiwarka miejsca pochówku
    Wojciech Skotak (2019)
    """

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
