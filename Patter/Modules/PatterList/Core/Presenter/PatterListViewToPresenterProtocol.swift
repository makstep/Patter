//
//  PatterListViewToPresenterProtocol.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import UIKit

protocol PatterListViewToPresenterProtocol: class {

    // MARK: - UITableView operations

    func countOfRows() -> Int
    func select(indexPath: IndexPath)
    func getCellData(indexPath: IndexPath) -> PatterData

    // MARK: - Router related events

    func routeConfirmDeletingAlert(indexPath: IndexPath)
    func routeNewPatterForm()

    // MARK: - UISearchController operations

    func search(by searchText: String)
}
