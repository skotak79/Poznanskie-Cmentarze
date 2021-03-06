//
//  DetailView.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 27/08/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import UIKit
import MapKit

final class DetailView: UIView {
    internal let mapView = MKMapView()
    internal lazy var segmentedControl: UISegmentedControl = {
        let items = ["Zwykła", "Hybrydowa", "Satelitarna"]
        var segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0

        return segmentedControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func setupConstraints() {
        addSubview(mapView)
        addSubview(segmentedControl)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            mapView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -8)
            ])
        NSLayoutConstraint.activate([
            segmentedControl.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 8),
            segmentedControl.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -8),
            segmentedControl.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
            ])
    }
}
