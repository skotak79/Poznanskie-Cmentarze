//
//  GraveListViewController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 14.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

/// Show list of graves
final class GraveListViewController: UIViewController {
    private(set) var tableView: UITableView!
    let adapter = Adapter<GraveViewModel, GraveCell>()
    private(set) var emptyView = EmptyView(text: "Nie znaleziono grobów")

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .white
        tableView = UITableView(frame: .zero)
        tableView.dataSource = adapter
        tableView.delegate = adapter
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(GraveCell.self, forCellReuseIdentifier: "GraveCell")
        tableView.backgroundColor = Color.background
        tableView.alwaysBounceVertical = true

        adapter.configure = { graveViewModel, cell in
            cell.textLabel?.attributedText = graveViewModel.attributedTitle
            cell.detailTextLabel?.attributedText = graveViewModel.attributedSubtitle
        }
        view.addSubview(tableView)
        NSLayoutConstraint.pin(view: tableView, toEdgesOf: view)
        view.addSubview(emptyView)
        NSLayoutConstraint.pin(view: emptyView, toEdgesOf: view)
        emptyView.alpha = 0
    }

    func handle(result: Result<[Grave]>) {
        switch result {
        case .success(let graves):
            let viewModels = graves.map {GraveViewModel.init(grave: $0)}.sorted(by: >)
            adapter.items = viewModels
            DispatchQueue.main.async {
                self.tableView.reloadData()
                UIView.animate(withDuration: 0.25, animations: {
                    self.emptyView.alpha = graves.isEmpty ? 1 : 0
                })
            }
        case .failure(let error):
            self.showErrorMessage(withError: error)
        }
    }
}
