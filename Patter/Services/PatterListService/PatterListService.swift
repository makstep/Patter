//
//  PatterAliveList.swift
//  Patter
//
//  Created by Maksim Ivanov on 09/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol PatterListServiceDelegate: class {
    func changed(deletions: [Int], insertions: [Int], modifications: [Int])
    func reloadEntities()
}

protocol PatterListService: class {
    var delegate: PatterListServiceDelegate? { get set }

    func getDataEntities() -> [PatterData]
    func filterByName(_ name: String)
}
