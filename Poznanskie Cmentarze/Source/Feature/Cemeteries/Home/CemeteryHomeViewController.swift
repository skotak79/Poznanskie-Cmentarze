//
//  CemeteryHomeViewController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 08.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

final class CemeteryHomeViewController: UIViewController, UITabBarControllerDelegate {
    
    var select: ((Cemetery) -> Void)?
    
    private var refreshControl = UIRefreshControl()
    private let cemeteriesService: CemeteriesService
    private let cemeteryListViewController = CemeteryListViewController()
    
    // MARK: - Init
    
    required init(cemeteriesService: CemeteriesService) {
        self.cemeteriesService = cemeteriesService
        super.init(nibName: nil, bundle: nil)
        self.title = "Cmentarze"
        tabBarController?.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - View life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
    }
    
    // MARK: - Setup
    
    private func setup() {
        cemeteryListViewController.adapter.select = select
        add(childViewController: cemeteryListViewController)
        cemeteryListViewController.tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    // MARK: - Action
    
    @objc private func refresh() {
        loadData()
    }
    
    // MARK: - Data
    
    private func loadData() {
        refreshControl.beginRefreshing()
        cemeteriesService.fetchAll(completion: { [weak self] result in
            switch result {
            case .success(let cemeteries):
                self?.cemeteryListViewController.handle(cemeteries: cemeteries)
            case .failure(let error):
                self?.showErrorMessage(withError: error)
            }
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
        })
    }
}
