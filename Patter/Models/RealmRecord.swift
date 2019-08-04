//
//  RealmRecord.swift
//  Patter
//
//  Created by Maksim Ivanov on 11/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import RealmSwift

protocol RecordProtocol: BasicEntityProtocol {
    var url: String { get set }
    var order: Int { get set }
    var isStarred: Bool { get set }
    var duration: Int { get set }
}

struct RecordData: RecordProtocol {
    var id: PrimaryKey
    var url: String
    var order: Int
    var isStarred: Bool
    var createdAt: Date?
    var duration: Int
}

final class RealmRecord: Object, RecordProtocol {

    @objc dynamic var id = UUID().uuidString
    @objc dynamic var url: String = ""
    @objc dynamic var order: Int = -1
    @objc dynamic var createdAt: Date?
    @objc dynamic var isStarred: Bool = false
    @objc dynamic var duration: Int = 0

    @objc dynamic var patter: RealmPatter?

    override static func primaryKey() -> String? {
        return "id"
    }

}

extension RealmRecord: TransferableProtocol {

    typealias DataStruct = RecordData

    var transferData: DataStruct {
        get {
            return DataStruct(id: id, url: url, order: order, isStarred: isStarred, createdAt: createdAt,
                              duration: duration)
        }

        set {
            url = newValue.url
        }
    }

}
