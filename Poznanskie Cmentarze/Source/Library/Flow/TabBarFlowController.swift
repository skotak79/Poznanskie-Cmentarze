//
//  TabBarFlowController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 08.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

/// Manage Tabbar controller and its flow controllers
final class TabBarFlowController: UITabBarController {
    /// Start the flow
    func start() {
        let cemeteryFlowController = CemeteryFlowController()
        let graveFlowController = GraveFlowController()
        let aboutViewController = AboutViewController()
        let tabs = [cemeteryFlowController, graveFlowController, aboutViewController]

        cemeteryFlowController.start()
        graveFlowController.start()
        aboutViewController.start()
        self.viewControllers = tabs
        self.selectedIndex = 0
    }
}
