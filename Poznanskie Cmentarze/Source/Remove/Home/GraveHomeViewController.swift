////
////  GraveHomeViewController.swift
////  Poznanskie Cmentarze
////
////  Created by Wojtek Skotak on 14.11.2018.
////  Copyright © 2018 Wojtek Skotak. All rights reserved.
////
//
//import UIKit
//
///// Show a list of graves
//final class GraveHomeViewController: UIViewController {
//    
//    /// When a grave get select
//    var select: ((GraveViewModel) -> Void)?
//
//    private let gravesService: GravesService
//    private let searchComponent: SearchComponent
//    private let graveListViewController = GraveListViewController()
//    
//    // MARK: - Init
//
//    required init(gravesService: GravesService) {
//        self.gravesService = gravesService
//        self.searchComponent = SearchComponent(gravesService: gravesService)
//        super.init(nibName: nil, bundle: nil)
//        self.title = "Wyszukiwarka miejsc pochówku"
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError()
//    }
//
//    // MARK: - View life Cycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setup()
//        setupSearch()
//    }
//
//    // MARK: - Setup
//
//    private func setup() {
//        graveListViewController.adapter.select = select
//        add(childViewController: graveListViewController)
//    }
//    
//    private func setupSearch() {
//        searchComponent.add(to: self)
//        searchComponent.graveListViewController.adapter.select = select
//    }
//}
