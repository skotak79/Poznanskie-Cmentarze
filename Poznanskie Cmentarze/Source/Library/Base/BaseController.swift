//
//  BaseController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 14.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

/// Used to separate between controller and view
class BaseController<T: UIView>: UIViewController {
    let root = T()
    
    override func loadView() {
        view = root
    }
}
