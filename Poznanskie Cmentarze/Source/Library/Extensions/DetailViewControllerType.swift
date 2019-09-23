//
//  DetailViewController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 27/08/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import Foundation

protocol DetailViewControllerType {}
extension DetailViewControllerType where Self: BaseController<DetailView> {

    internal func setSegmentedControlTarget() {
        root.segmentedControl.addAction { [weak self] in
            self?.changeMapType()
        }
    }

    internal func changeMapType() {
        switch root.segmentedControl.selectedSegmentIndex {
        case 0:
            root.mapView.mapType = .standard
        case 1:
            root.mapView.mapType = .hybrid
        default:
            root.mapView.mapType = .satellite
        }
    }   
}
