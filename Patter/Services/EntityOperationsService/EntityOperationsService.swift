//
//  EntityOperationsService.swift
//  Patter
//
//  Created by Maksim Ivanov on 14/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol EnitiyOperationsService: class {
    func createPatterWithName(_ name: String)
    func deletePatter(id: String)
}
