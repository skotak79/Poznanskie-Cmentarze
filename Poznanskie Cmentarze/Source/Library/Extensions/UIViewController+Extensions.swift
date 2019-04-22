//
//  UIViewController+Extensions.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 14.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Add child view controller and its view
    func add(childViewController: UIViewController) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }

    /// Show alert with error message
    func showErrorMessage(withError error: LoadingError) {

        let alert = UIAlertController(title: "Błąd", message: error.makeErrorMessage(), preferredStyle: .alert)
        alert.addAction(title: "OK", style: .default, handler: nil)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
