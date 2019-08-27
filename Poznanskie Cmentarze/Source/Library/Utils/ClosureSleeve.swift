//
//  ClosureSleeve.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 27/08/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import Foundation

class ClosureSleeve {
    let closure: () -> Void

    init(_ closure: @escaping () -> Void) {
        self.closure = closure
    }

    @objc func invoke () {
        closure()
    }
}
