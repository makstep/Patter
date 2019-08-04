//
//  PatterListDefaultInteractor.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import RealmSwift

final class PatterListDefaultInteractor: PatterListInteractor {

    // MARK: - VIPER

    weak var presenter: PatterListInteractorToPresenterProtocol?

    // MARK: - Services

    private let patterListService: PatterListService
    private let entityOperationsService: EnitiyOperationsService

    // MARK: - Initialization

    init(patterListService: PatterListService, entityOperationsService: EnitiyOperationsService) {
        self.patterListService = patterListService
        self.entityOperationsService = entityOperationsService

        self.patterListService.delegate = self
    }

}

// MARK: - Extentions

extension PatterListDefaultInteractor: PatterListPresenterToInteractorProtocol {

    var dataEntities: [PatterData] {
        return patterListService.getDataEntities()
    }

    func createEntity(name: String) {
        entityOperationsService.createPatterWithName(name)
    }

    func deleteEntity(id: String) {
        entityOperationsService.deletePatter(id: id)
    }

    func filterBy(name: String) {
        patterListService.filterByName(name)
    }

}

extension PatterListDefaultInteractor: PatterListServiceDelegate {

    func changed(deletions: [Int], insertions: [Int], modifications: [Int]) {
        presenter?.entitiesChanged(deletions: deletions,
                                   insertions: insertions,
                                   modifications: modifications)
    }

    func reloadEntities() {
        presenter?.entitiesInitialized()
    }

}
