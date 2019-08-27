//
//  GraveDetailView.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 15.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit
import MapKit


//final class GraveDetailView: DetailView {


//    private(set) lazy var yearsLabel: UILabel = self.makeLabel()
//    private(set) lazy var cemeteryNameLabel: UILabel = self.makeLabel()
//    private(set) lazy var fieldQuarterRowPlaceLabel: UILabel = self.makeLabel()
    //var tileRenderer = MKOverlayRenderer()
    //internal let annotation = MKPointAnnotation()

    // MARK: - Init

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupConstraints()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError()
//    }

//    func addMapAnnotation(from location: CLLocationCoordinate2D) {
//        addAnnotation(annotation: annotation, from: location, on: mapView)
//    }

//    func setMapRegion(region: MKCoordinateRegion) {
//        mapView.setRegion(region, animated: true)
//    }

    // MARK: - Setup

//    private func setupConstraints() {
//        addSubview(mapView)
//        addSubview(segmentedControl)
//
//        NSLayoutConstraint.pin(view: mapView, toEdgesOf: self)
//        NSLayoutConstraint.activate([
//        segmentedControl.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
//        segmentedControl.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16)
//            ])
//        addSubview(yearsLabel)
//        addSubview(cemeteryNameLabel)
//        addSubview(fieldQuarterRowPlaceLabel)
//        NSLayoutConstraint.activate([
//        fieldQuarterRowPlaceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
//        fieldQuarterRowPlaceLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
//        fieldQuarterRowPlaceLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
//        cemeteryNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
//        cemeteryNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
//        cemeteryNameLabel.bottomAnchor.constraint(equalTo: fieldQuarterRowPlaceLabel.topAnchor, constant: -5),
//        yearsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
//        yearsLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
//        yearsLabel.bottomAnchor.constraint(equalTo: cemeteryNameLabel.topAnchor, constant: -5),
//        mapView.rightAnchor.constraint(equalTo: self.rightAnchor),
//        mapView.leftAnchor.constraint(equalTo: self.leftAnchor),
//        mapView.topAnchor.constraint(equalTo: self.topAnchor),
//        mapView.bottomAnchor.constraint(equalTo: yearsLabel.topAnchor, constant: -10)
//        ])
        //setupMap()
  //  }

   // private func setupMap() {
//        mapView.showsCompass = true
//        mapView.showsScale = true
        //tileRenderer = setTileRenderer(on: mapView)
        //mapView.delegate = self
   // }
//}

//extension GraveDetailView: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        return tileRenderer
//    }
//}
