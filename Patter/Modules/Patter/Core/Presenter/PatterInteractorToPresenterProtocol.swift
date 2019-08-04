//
//  PatterInteractorToPresenter.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol PatterInteractorToPresenterProtocol: class {
    func updateTimer(timeIterval: TimeInterval)
    func unfocusRecords()
    func notifyFileLost(at index: Int)
}
