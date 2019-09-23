//
//  CemeteryFlowController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 08.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

//import UIKit
//import MapKit
//
///// Manage list and detail screens for cemetery
//final class CemeteryFlowController: UINavigationController {
//
//    /// start the flow
//    func start() {
//        let service = CemeteriesService(networking: NetworkService())
//        let controller = CemeteryHomeViewController(cemeteriesService: service)
//        viewControllers = [controller]
//
//        controller.select = { [weak self] cemetery in
//         self?.startDetail(cemetery: cemetery)
//         }
//        let tabBarItem = UITabBarItem(title: "Cmentarze", image: R.image.graves(), tag: 1)
//        self.tabBarItem = tabBarItem
//    }
//
//    private func startDetail(cemetery: Cemetery) {
//        let controller = CemeteryDetailViewController(cemetery: cemetery)
//        controller.hidesBottomBarWhenPushed = true
//
////        controller.openMaps = { [weak self] coordinates, description in
////            self?.displayMapsWarning(coordinates: coordinates, description: description)
////        }
//        pushViewController(controller, animated: true)
//    }
//}
