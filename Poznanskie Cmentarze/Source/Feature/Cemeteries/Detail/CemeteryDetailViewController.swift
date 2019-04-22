//
//  CemeteryDetailViewController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 10.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit
import MapKit

/// Show detail information for a cemetery
final class CemeteryDetailViewController: BaseController<CemeteryDetailView> {
    
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
        let navigateButton = UIBarButtonItem(title: "Nawiguj", style: .plain, target: self, action: #selector(openMapsButtonTouched))
        self.navigationItem.rightBarButtonItem = navigateButton
    }
    
    private func update(cemetery: Cemetery) {
        root.addMapAnnotation(from: Helper.getGeoCenterLocation(of: cemetery))
    }

    // MARK: - Action

    @objc private func openMapsButtonTouched() {
        openMaps?(Helper.getGeoCenterLocation(of: cemetery), "Cmentarz \(cemetery.name)")
    }
}
