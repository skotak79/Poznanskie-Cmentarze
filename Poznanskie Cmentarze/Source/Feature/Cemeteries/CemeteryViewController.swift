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
    private(set) var cemeteries: [Cemetery] = []

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
        setup()
        loadData()
    }

    private func setup() {

        view.backgroundColor = .white
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(CemeteryCell.self, forCellReuseIdentifier: "CemeteryCell")
        tableView.backgroundColor = Color.background
        tableView.alwaysBounceVertical = true

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
                self?.cemeteries = cemeteries
                self?.handle(cemeteries: cemeteries)
            case .failure(let error):
                self?.showErrorMessage(withError: error)
            }
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
        })
    }

    private func showCemetery(with cemetery: Cemetery) {
        let cemeteryDetailViewController = CemeteryDetailViewController(cemetery: cemetery)
        navigationController?.pushViewController(cemeteryDetailViewController, animated: true)
    }

    func handle(cemeteries: [Cemetery]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension CemeteryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cemeteries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CemeteryCell.self), for: indexPath) as! CemeteryCell
        let item = cemeteries[indexPath.row]
        cell.textLabel?.attributedText = item.attributedTitle
        cell.detailTextLabel?.attributedText = item.attributedSubtitle
        return cell
    }
}

extension CemeteryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cemetery = cemeteries[indexPath.row]
        showCemetery(with: cemetery)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
