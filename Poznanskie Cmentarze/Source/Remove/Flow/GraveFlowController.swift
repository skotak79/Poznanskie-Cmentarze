//
//  GraveFlowController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 08.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

//import UIKit
//import MapKit
//
///// Manage list and detail screens for grave
//final class GraveFlowController: UINavigationController {
//
//    /// start the flow
//    func start() {
//        let service = GravesService(networking: NetworkService())
//        let controller = GraveHomeViewController(gravesService: service)
//        viewControllers = [controller]
//
//        controller.select = { [weak self] graveViewModel in
//            self?.startDetail(graveViewModel: graveViewModel)
//        }
//        let tabBarItem = UITabBarItem(title: "Wyszukiwarka", image: R.image.search(), tag: 2)
//        self.tabBarItem = tabBarItem
//    }
//
//    private func startDetail(graveViewModel: GraveViewModel) {
//        let controller = GraveDetailViewController(graveViewModel: graveViewModel)
//        controller.hidesBottomBarWhenPushed = true
////        controller.openMaps = { [weak self] coordinates, description in
////            self?.displayMapsWarning(coordinates: coordinates, description: description)
////        }
//        pushViewController(controller, animated: true)
//    }
//
//}
