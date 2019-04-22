//
//  UIAlertController+Action.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 06.12.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

// Extension to `UIAlertController` to allow direct adding of  `UIAlertAction` instances

extension UIAlertController {
    func addAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) {
        let alertAction = UIAlertAction(title: title, style: style, handler: handler)
        self.addAction(alertAction)
    }
}
