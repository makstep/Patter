//
//  protocols.swift
//  Patter
//
//  Created by Maksim Ivanov on 11/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

typealias PrimaryKey = String

protocol BasicEntityProtocol {
    var id: PrimaryKey { get set }
    var createdAt: Date? { get set }
}

protocol TransferableProtocol {
    associatedtype DataStruct
    var transferData: DataStruct { get set }
}
