//
//  UINavigationController+openMaps.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 27.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit
import MapKit

extension UINavigationController: UIPopoverPresentationControllerDelegate {
    internal func displayMapsWarning(coordinates: CLLocationCoordinate2D, description: String) {
        let alertController = UIAlertController()
        alertController.addAction(title: "Opuścić aplikację i otworzyć mapy?", style: .default) { [unowned self] _ in
                self.openMaps(coordinates: coordinates, description: description)
        }
        alertController.addAction(title: "Przerwij", style: .cancel, handler: nil)
        let popover = alertController.popoverPresentationController
        popover?.delegate = self
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
}

    internal func openMaps(coordinates: CLLocationCoordinate2D, description: String) {
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = description
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }
}
