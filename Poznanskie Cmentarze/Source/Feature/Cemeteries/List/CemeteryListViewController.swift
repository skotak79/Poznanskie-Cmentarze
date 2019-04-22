//
//  CemeteryListViewController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 08.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

/// Show list of cemeteries
final class CemeteryListViewController: UIViewController {
    
    private(set) var tableView: UITableView!
    let adapter = Adapter<Cemetery, CemeteryCell>()

// MARK: - Life Cycle

override func viewDidLoad() {
    super.viewDidLoad()
    setup()
}

private func setup() {
    
    view.backgroundColor = .white
    tableView = UITableView(frame: .zero, style: .plain)
    tableView.dataSource = adapter
    tableView.delegate = adapter
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44
    tableView.register(CemeteryCell.self, forCellReuseIdentifier: "CemeteryCell")
    tableView.backgroundColor = Color.background
    tableView.alwaysBounceVertical = true
    adapter.configure = { cemetery, cell in
        cell.textLabel?.attributedText = cemetery.attributedTitle
        cell.detailTextLabel?.attributedText = cemetery.attributedSubtitle
    }
    
    view.addSubview(tableView)
    NSLayoutConstraint.pin(view: tableView, toEdgesOf: view)
}
    func handle(cemeteries: [Cemetery]) {
        adapter.items = cemeteries
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
