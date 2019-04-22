//
//  AboutViewController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 08.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

final class AboutViewController: BaseController<AboutView> {
    
    func start() {
        let tabBarItem = UITabBarItem(title: "Info", image: R.image.info(), tag: 3)
        self.tabBarItem = tabBarItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
}
