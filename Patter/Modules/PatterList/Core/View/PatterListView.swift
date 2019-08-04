//
//  PatterListPresenterToViewProtocol.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol PatterListView: class {

    // MARK: - UITableView operations

    func animateAdding(at indexPath: IndexPath)
    func animateRemoving(at indexPath: IndexPath)
    func reloadTableView()

    // MARK: - UISearchController operations

    var isFiltering: Bool { get }

    // MARK: - Updating table

    func updateTableView(deletions: [Int], insertions: [Int], modifications: [Int])
}
