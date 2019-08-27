//
//  CemeteryDetailViewController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 10.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit
import MapKit

/// Show detailed information of the cemetery
final class CemeteryDetailViewController: BaseController<DetailView>, DetailViewController {
    
    private let cemetery: Cemetery
    var openMaps: ((CLLocationCoordinate2D, String) -> Void)?
    
    // MARK: - Init

    required init(cemetery: Cemetery) {
        self.cemetery = cemetery
        super.init(nibName: nil, bundle: nil)
        self.title = cemetery.name
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background
        setup()
        update(cemetery: cemetery)
    }

    private func setup() {
        setupNavigationButton()
        setSegmentedControlTarget()
    }

    private func setupNavigationButton() {
        let navigateButton = UIBarButtonItem(title: "Nawiguj", style: .plain, target: self, action: #selector(openMapsButtonTouched))
        self.navigationItem.rightBarButtonItem = navigateButton
    }

    private func update(cemetery: Cemetery) {
        let centerLocation = Helper.getGeoCenterLocation(of: cemetery)
        let latDelta = max(0.002, fabs(cemetery.topLeftCoordinate.latitude - cemetery.bottomRightCoordinate.latitude)*3)
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: 0.0)
        let region = MKCoordinateRegion(center: centerLocation, span: span)
        root.mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = centerLocation
        annotation.title = cemetery.name
        annotation.subtitle = cemetery.type
        root.mapView.addAnnotation(annotation)
    }

    @objc private func openMapsButtonTouched() {
        openMaps?(Helper.getGeoCenterLocation(of: cemetery), "Cmentarz \(cemetery.name)")
    }
}
