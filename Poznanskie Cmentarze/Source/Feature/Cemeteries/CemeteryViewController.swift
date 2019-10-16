//
//  CemeteryViewController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 11/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import UIKit

final class CemeteryViewController: UIViewController {

    let cemeteryModel: CemeteryModel
    private(set) var tableView: UITableView!
    private var refreshControl = UIRefreshControl()
    let adapter = Adapter<Cemetery, CemeteryCell>()

    required init(cemeteryModel: CemeteryModel) {
        self.cemeteryModel = cemeteryModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        title = "Cmentarze"
        setupTableView()
        loadData()
    }

    private func setupTableView() {

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
        adapter.select = { [weak self] cemetery in
            self?.startDetail(with: cemetery)
        }

        view.addSubview(tableView)
        NSLayoutConstraint.pin(view: tableView, toEdgesOf: view)

        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    // MARK: - Action

    @objc private func refresh() {
        loadData()
    }

    // MARK: - Data

    private func loadData() {
        refreshControl.beginRefreshing()
        cemeteryModel.fetchAll(completion: { [weak self] result in
            switch result {
            case .success(let cemeteries):
                self?.adapter.items = cemeteries
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                self?.showErrorMessage(withError: error)
            }
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
        })
    }

    private func startDetail(with cemetery: Cemetery) {
        let cemeteryDetailViewController = CemeteryDetailViewController(cemetery: cemetery)
        navigationController?.pushViewController(cemeteryDetailViewController, animated: true)
    }
}
