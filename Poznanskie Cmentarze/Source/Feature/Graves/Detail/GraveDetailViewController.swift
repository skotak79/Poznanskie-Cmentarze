//
//  GraveDetailViewController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 15.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit
import MapKit

/// Show detailed information of the grave
final class GraveDetailViewController: BaseController<DetailView>, DetailViewController {
    
    private let graveViewModel: GraveViewModel
    var openMaps: ((CLLocationCoordinate2D, String) -> Void)?
    
    // MARK: - Init
    
    required init(graveViewModel: GraveViewModel) {
        self.graveViewModel = graveViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.loadView()
        view.backgroundColor = Color.background
        setup()
        update(graveViewModel: graveViewModel)
    }

    private func setup() {
        setupNavigationButton()
        setSegmentedControlTarget()
    }

    private func setupNavigationButton() {
        let navigateButton = UIBarButtonItem(title: "Nawiguj", style: .plain, target: self, action: #selector(openMapsButtonTouched))
        self.navigationItem.rightBarButtonItem = navigateButton
    }

    private func update(graveViewModel: GraveViewModel) {
        if let location = graveViewModel.location {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
            root.mapView.setRegion(region, animated: true)

            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "\(graveViewModel.cmName)\n \(graveViewModel.fieldQuarterRowPlace)"
            annotation.subtitle = "\(graveViewModel.nameAndSurname)\n \(graveViewModel.years)"
            root.mapView.addAnnotation(annotation)
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }

    // MARK: - Action

    @objc private func openMapsButtonTouched() {
        if let location = graveViewModel.location {
            openMaps?(location, "Miejsce spoczynku osoby: \(graveViewModel.nameAndSurname)")
        }
    }
}
