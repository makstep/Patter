//
//  PatterListDefaultPresenter.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import UIKit

final class PatterListDefaultPresenter: PatterListPresenter {

    // MARK: - VIPER

    weak var view: PatterListView?
    var router: PatterListRouter!
    var interactor: PatterListPresenterToInteractorProtocol!

    // MARK: - Fields

    private let appConfig = ApplicationConfiguration()

    var patters: [PatterData] {
        return interactor.dataEntities
    }

    // MARK: - Initialization

    required init(interactor: PatterListPresenterToInteractorProtocol, router: PatterListRouter, view: PatterListView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }

}

// MARK: - Extention methods called from view

extension PatterListDefaultPresenter: PatterListViewToPresenterProtocol {

    func routeConfirmDeletingAlert(indexPath: IndexPath) {
        router.presentConfirmDeleteAlert(indexPath: indexPath, patterName: patters[indexPath.row].name)
    }

    func routeNewPatterForm() {
        router.presentNewPatterFormAlert()
    }

    func addPatter(name: String) {
        interactor.createEntity(name: name)
    }

    func getCellData(indexPath: IndexPath) -> PatterData {
        return patters[indexPath.row]
    }

    func delete(indexPath: IndexPath) {
        let patter = patters[indexPath.row]

        interactor.deleteEntity(id: patter.id)
    }

    func select(indexPath: IndexPath) {
        router.navigateToPatter(id: patters[indexPath.row].id)
    }

    func countOfRows() -> Int {
        return patters.count
    }

    func search(by searchText: String) {
        interactor.filterBy(name: searchText)
    }

}

// MARK: - Extention methods to presenter

extension PatterListDefaultPresenter: PatterListInteractorToPresenterProtocol {

    func entitiesInitialized() {
        view?.reloadTableView()
    }

    func entitiesChanged(deletions: [Int], insertions: [Int], modifications: [Int]) {
        view?.updateTableView(deletions: deletions, insertions: insertions, modifications: modifications)
    }

}
