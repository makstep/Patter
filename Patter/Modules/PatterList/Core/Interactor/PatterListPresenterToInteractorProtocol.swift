//
//  PatterListPresenterToInteractorProtocol.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol PatterListPresenterToInteractorProtocol {
    var dataEntities: [PatterData] { get }

    func createEntity(name: String)
    func deleteEntity(id: String)
    func filterBy(name: String)
}
