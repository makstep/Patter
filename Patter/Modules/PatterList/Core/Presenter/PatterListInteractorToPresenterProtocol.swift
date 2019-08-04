//
//  PatterListInteractorToPresenterProtocol.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol PatterListInteractorToPresenterProtocol: class {
    func entitiesInitialized()
    func entitiesChanged(deletions: [Int], insertions: [Int], modifications: [Int])
}
