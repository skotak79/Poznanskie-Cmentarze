//
//  GraveListViewController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 14/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import UIKit

final class GraveListViewController: UIViewController {
    private(set) var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableView()
    }

    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(GraveCell.self, forCellReuseIdentifier: "GraveCell")
        tableView.backgroundColor = .white
        tableView.alwaysBounceVertical = true

        view.addSubview(tableView)
        NSLayoutConstraint.pin(view: tableView, toEdgesOf: view)
    }
}
