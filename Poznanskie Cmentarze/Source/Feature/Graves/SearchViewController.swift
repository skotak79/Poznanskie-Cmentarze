//
//  SearchViewController.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 11/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    private var viewModels = [GraveViewModel]()
    private var cemeteriesIdWithNames: [Int: String] = [:] {
        didSet {
            self.hideLoadingIndicator()
            self.searchController?.searchBar.isUserInteractionEnabled = true
        }
    }

    private let cemeteryModel: CemeteryModel
    private let searchModel: SearchModel
    private var searchController: UISearchController!
    private var listController = GraveListViewController()

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
        setupListController()
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

    private func setupListController() {
        add(childViewController: listController)
        listController.tableView.delegate = self
        listController.tableView.dataSource = self
    }

    private func setupSearchController() {

        self.searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.keyboardType = .alphabet
        searchController.searchBar.placeholder = "Nazwisko lub Imię(Imiona) Nazwisko"

        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            listController.tableView.tableHeaderView = searchController.searchBar
        }

        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
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

        let view = UIActivityIndicatorView(style: .whiteLarge)
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
        self.viewModels = viewModels
        hideLoadingIndicator()
        DispatchQueue.main.async {
            print(graves.count)
            self.listController.tableView.reloadData()
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

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let graveViewModel = viewModels[indexPath.row]
        let detailViewController = GraveDetailViewController(graveViewModel: graveViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GraveCell.self), for: indexPath) as! GraveCell
        let item = viewModels[indexPath.row]
        cell.textLabel?.attributedText = item.attributedTitle
        cell.detailTextLabel?.attributedText = item.attributedSubtitle
        return cell
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

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // no op
    }
}
