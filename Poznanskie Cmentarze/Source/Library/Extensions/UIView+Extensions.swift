//
//  UIView+Extensions.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 14.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

extension UIView {

    /// Convenient method to add a list of subviews
    func addSubviews(_ views: [UIView]) {
        views.forEach({
            addSubview($0)
        })
    }
}
