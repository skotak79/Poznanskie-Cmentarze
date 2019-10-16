//
//  SearchViewController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 11/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    private var cemeteriesIdWithNames: [Int: String] = [:] {
        didSet {
            self.hideLoadingIndicator()
            self.searchController?.searchBar.isUserInteractionEnabled = true
        }
    }

    private let cemeteryModel: CemeteryModel
    private let searchModel: SearchModel
    private var searchController: UISearchController!
    private(set) var tableView: UITableView!
    let adapter = Adapter<GraveViewModel, GraveCell>()

    private lazy var loadingIndicator: UIActivityIndicatorView = self.makeLoadingIndicator()

    private(set) var emptyView = EmptyView(text: "Nie znaleziono grobów")

    required init(searchModel: SearchModel, cemeteryModel: CemeteryModel) {
        self.searchModel = searchModel
        self.cemeteryModel = cemeteryModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = "Wyszukiwarka"
        setupTableView()
        setupSearchController()
        setupIndicator()
        setupEmptyView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.cemeteriesIdWithNames.isEmpty {
            self.showLoadingIndicator()
            self.searchController.searchBar.isUserInteractionEnabled = false
        }
    }

    // MARK: - Setup

    private func setupTableView() {

        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(GraveCell.self, forCellReuseIdentifier: "GraveCell")
        tableView.backgroundColor = .white
        tableView.alwaysBounceVertical = true
        adapter.configure = { graveViewModel, cell in
            cell.textLabel?.attributedText = graveViewModel.attributedTitle
            cell.detailTextLabel?.attributedText = graveViewModel.attributedSubtitle
        }
        adapter.select = { [weak self] graveViewModel in
            self?.startDetail(with: graveViewModel)
        }
        view.addSubview(tableView)
        NSLayoutConstraint.pin(view: tableView, toEdgesOf: view)
    }

    private func setupSearchController() {

        self.searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.keyboardType = .alphabet
        searchController.searchBar.placeholder = "Nazwisko lub Imię(Imiona) Nazwisko"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.delegate = self
        searchController.automaticallyShowsCancelButton = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }

    private func setupIndicator() {
        self.view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100)
            ])
    }

    private func setupEmptyView() {
        view.addSubview(emptyView)
        NSLayoutConstraint.pin(view: emptyView, toEdgesOf: view)
        emptyView.alpha = 0
    }

    // MARK: - Make

    private func makeLoadingIndicator() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .darkGray
        view.hidesWhenStopped = true
        return view
    }

    private func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.emptyView.alpha = 0
            self.searchController.searchBar.resignFirstResponder()
            self.loadingIndicator.startAnimating()
        }
    }

    private func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
    }

    private func startDetail(with graveViewModel: GraveViewModel) {
        let graveDetailViewController = GraveDetailViewController(graveViewModel: graveViewModel)
        navigationController?.pushViewController(graveDetailViewController, animated: true)
    }
}

extension SearchViewController: SearchModelDelegate {
    func searchModel(_ searchModel: SearchModel, didReceive error: LoadingError) {
        self.hideLoadingIndicator()
        self.showErrorMessage(withError: error)
    }

    func searchModel(_ searchModel: SearchModel, didChange isFetchingGraves: Bool) {
        if isFetchingGraves {
            showLoadingIndicator()
        }
    }

    func searchModel(_ searchModel: SearchModel, didFetched graves: [Grave]) {
        let viewModels = graves.map {GraveViewModel.init(grave: $0, cemeteryIdsWithNames: cemeteriesIdWithNames)}.sorted(by: >)
        adapter.items = viewModels
        hideLoadingIndicator()
        DispatchQueue.main.async {
            print(graves.count)
            self.tableView.reloadData()
            UIView.animate(withDuration: 0.25, animations: {
                self.emptyView.alpha = graves.isEmpty ? 1 : 0
            })
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchModel.fetchGraves(with: searchText)
        }
    }
}

extension SearchViewController: CemeteryModelDelegate {
    func cemeteryModel(_ cemeteryModel: CemeteryModel, didFetchedCemeteries cemeteries: [Cemetery]) {
            self.cemeteriesIdWithNames = Dictionary(uniqueKeysWithValues: cemeteries.map {
            ($0.id, $0.properties.name)
        })
    }
}

extension SearchViewController: UISearchControllerDelegate {}
