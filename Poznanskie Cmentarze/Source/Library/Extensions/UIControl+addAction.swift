//
//  UIControl+addAction.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 27/08/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import UIKit

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .valueChanged, _ closure: @escaping () -> Void) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
