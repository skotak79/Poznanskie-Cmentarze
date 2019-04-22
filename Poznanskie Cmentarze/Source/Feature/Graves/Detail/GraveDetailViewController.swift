//
//  GraveDetailViewController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 15.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit
import MapKit

/// Show detail information for a grave
final class GraveDetailViewController: BaseController<GraveDetailView> {
    
    private let graveViewModel: GraveViewModel
    var openMaps: ((CLLocationCoordinate2D, String) -> Void)?
    
    // MARK: - Init
    
    required init(graveViewModel: GraveViewModel) {
        self.graveViewModel = graveViewModel
        super.init(nibName: nil, bundle: nil)
        self.title = graveViewModel.nameAndSurname
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
        let navigateButton = UIBarButtonItem(title: "Nawiguj", style: .plain, target: self, action: #selector(openMapsButtonTouched))
        self.navigationItem.rightBarButtonItem = navigateButton
    }
    
    private func update(graveViewModel: GraveViewModel) {
        if let location = graveViewModel.location {
            root.addMapAnnotation(from: location)
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        root.yearsLabel.text = graveViewModel.years
        root.cemeteryNameLabel.text = graveViewModel.cmName
        root.fieldQuarterRowPlaceLabel.text = graveViewModel.fieldQuarterRowPlace
    }
    
    // MARK: - Action

    @objc private func openMapsButtonTouched() {
        if let location = graveViewModel.location {
        openMaps?(location, "Miejsce spoczynku osoby: \(graveViewModel.nameAndSurname)")
        }
    }
}
