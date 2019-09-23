//
//  AppDelegate.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 08.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let cemeteryModel = CemeteryModel()
    let searchModel = SearchModel()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if let viewControllers = (window?.rootViewController as? UITabBarController)?.viewControllers {
            for value in viewControllers.enumerated() {
                switch value {
                case let (0, navigatorController as UINavigationController):
                    let cemeteryViewController = CemeteryViewController(cemeteryModel: cemeteryModel)
                    navigatorController.setViewControllers([cemeteryViewController], animated: false)
                case let (1, navigatorController as UINavigationController):
                    let searchViewController = SearchViewController(searchModel: searchModel, cemeteryModel: cemeteryModel)
                    searchModel.delegate = searchViewController
                    cemeteryModel.delegate = searchViewController
                    navigatorController.setViewControllers([searchViewController], animated: false)
                default: continue
                }
            }
        }
        return true
    }
}
