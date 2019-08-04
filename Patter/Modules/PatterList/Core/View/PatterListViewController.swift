//
//  ViewController.swift
//  Patter
//
//  Created by Maksim Ivanov on 07/03/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit
import CoreData

final class PatterListViewController: UITableViewController {

    // MARK: - VIPER

    var presenter: PatterListViewToPresenterProtocol!

    // MARK: - Fields

    let searchController = UISearchController(searchResultsController: nil)

    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    var isSearchBarEmpty: Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationItem()
    }

    // MARK: - Private

    private func setUpNavigationItem() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"

        self.definesPresentationContext = true

        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(presentPatterForm))
    }

}

// MARK: - UITableViewDelegate & UITableViewDataSource overrides

extension PatterListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatterCell")!
        let patterData = presenter.getCellData(indexPath: indexPath)

        if patterData.name.isEmpty {
            cell.textLabel?.text = "❗️ No Name"
            cell.textLabel?.textColor = .red
        } else {
            cell.textLabel?.text = patterData.name
            cell.textLabel?.textColor = .darkText
        }

        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
        ) {
        if editingStyle == .delete {
            presenter.routeConfirmDeletingAlert(indexPath: indexPath)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.select(indexPath: indexPath)
    }

}

// MARK: - UISerachController methods

extension PatterListViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else { return }
        presenter.search(by: searchString)
    }

}

// MARK: - Update Patter name, body fields

extension PatterListViewController: PatterListView {

    func animateAdding(at indexPath: IndexPath) {
        self.tableView.insertRows(at: [indexPath], with: .fade)
    }

    func animateRemoving(at indexPath: IndexPath) {
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    func reloadTableView() {
        tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .fade)
    }

    func updateTableView(deletions: [Int], insertions: [Int], modifications: [Int]) {
        tableView.beginUpdates()
        tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) },
                                  with: .automatic)
        tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) },
                                  with: .fade)
        tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) },
                                  with: .automatic)
        tableView.endUpdates()
    }

    @objc private func presentPatterForm() {
        presenter.routeNewPatterForm()
    }

}
