//
//  NSLayoutConstraint+Extensions.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 14.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {

    /// Activate constraints
    ///
    /// - Parameter constraints: An array of constraints
    static func activate(_ constraints: [NSLayoutConstraint]) {
        constraints.forEach {
            ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
            $0.isActive = true
        }
    }

    static func pin(view: UIView, toEdgesOf anotherView: UIView) {
        activate([
            view.topAnchor.constraint(equalTo: anotherView.topAnchor),
            view.leftAnchor.constraint(equalTo: anotherView.leftAnchor),
            view.rightAnchor.constraint(equalTo: anotherView.rightAnchor),
            view.bottomAnchor.constraint(equalTo: anotherView.bottomAnchor)
            ])
    }

    static func pinToSafeAreas(view: UIView, toEdgesOf anotherView: UIView) {
        activate([
            view.topAnchor.constraint(equalTo: anotherView.safeAreaLayoutGuide.topAnchor),
            view.leftAnchor.constraint(equalTo: anotherView.safeAreaLayoutGuide.leftAnchor),
            view.rightAnchor.constraint(equalTo: anotherView.safeAreaLayoutGuide.rightAnchor),
            view.bottomAnchor.constraint(equalTo: anotherView.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}
