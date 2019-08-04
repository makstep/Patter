//
//  RealmPatter.swift
//  Patter
//
//  Created by Maksim Ivanov on 11/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import RealmSwift

protocol PatterProtocol: BasicEntityProtocol {
    var name: String { get set }
    var text: String { get set }
}

struct PatterData: PatterProtocol, Decodable {
    var id: PrimaryKey
    var name: String
    var text: String
    var createdAt: Date?
}

final class RealmPatter: Object, PatterProtocol {

    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var text: String = ""
    @objc dynamic var createdAt: Date?

    var records = List<RealmRecord>()

    override static func primaryKey() -> String? {
        return "id"
    }

}

extension RealmPatter: TransferableProtocol {
    typealias DataStruct = PatterData

    var transferData: DataStruct {
        get {
            return DataStruct(id: id, name: name, text: text, createdAt: createdAt)
        }

        set {
            name = newValue.name
            text = newValue.text
        }
    }
}
