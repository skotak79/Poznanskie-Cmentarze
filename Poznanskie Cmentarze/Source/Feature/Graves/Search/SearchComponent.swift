//
//  SearchComponent.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 08.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

final class SearchComponent: NSObject, UISearchResultsUpdating, UISearchBarDelegate {
    let gravesService: GravesService
    let searchController: UISearchController
    let graveListViewController = GraveListViewController()
    private lazy var loadingIndicator: UIActivityIndicatorView = self.makeLoadingIndicator()
    /// Avoid making lots of requests when user types fast
    /// This throttles the search requests
    let debouncer = Debouncer(delay: 1)
    required init(gravesService: GravesService) {
        self.gravesService = gravesService
        self.searchController = UISearchController(searchResultsController: graveListViewController)
        super.init()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "Nazwisko lub Imię(Imiona) Nazwisko"
        searchController.searchBar.keyboardType = .alphabet
        graveListViewController.view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: graveListViewController.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: graveListViewController.view.centerYAnchor, constant: -100)
            ])
    }

    /// Add search bar to view controller
    func add(to viewController: UIViewController) {
        if #available(iOS 11, *) {
            viewController.navigationItem.searchController = searchController
            viewController.navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            viewController.navigationItem.titleView = searchController.searchBar
        }
        viewController.definesPresentationContext = true
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        // No op
    }

    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debouncer.schedule { [weak self] in
            self?.performSearch()
        }
    }

    // MARK: - Logic

    private func performSearch() {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            return
        }
        search(query: text)
    }

    private func search(query: String) {
        DispatchQueue.main.async {
            self.graveListViewController.emptyView.alpha = 0
            self.graveListViewController.tableView.alpha = 0
            self.loadingIndicator.startAnimating()

        }
        let name = Name(searchText: query)
        gravesService.search(name: name, completion: { [weak self] result in
            switch result {
            case .success(let graves):
                if !graves.isEmpty {
                self?.searchController.searchBar.resignFirstResponder()
                }
                fallthrough
            default:
                self?.hideIndicator()
                self?.graveListViewController.handle(result: result)
                }
            })
    }

    private func hideIndicator() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.graveListViewController.tableView.alpha = 1
        }
    }

    // MARK: - Make
    
    private func makeLoadingIndicator() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.color = .darkGray
        view.hidesWhenStopped = true
        return view
    }
}
