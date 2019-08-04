//
//  RealmPatterEntityDefaultService.swift
//  Patter
//
//  Created by Maksim Ivanov on 11/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmPatterEntityDefaultService: RealmPatterEntityService {

    private let realm = try! Realm()
    private let fileService: FileService

    let patter: RealmPatter
    private(set) var records: List<RealmRecord>

    init(patter: RealmPatter, fileService: FileService) {
        self.patter = patter
        self.records = patter.records
        self.fileService = fileService
    }

    convenience init(id: PrimaryKey, fileService: FileService) {
        let patter = try! Realm().object(ofType: RealmPatter.self, forPrimaryKey: id)!
        self.init(patter: patter, fileService: fileService)
    }

    // MARK: - Patter fields

    func changeName(_ name: String) {
        try! realm.write {
            patter.name = name
            realm.add(patter, update: true)
        }
    }

    func changeText(_ text: String) {
        try! realm.write {
            patter.text = text
            realm.add(patter, update: true)
        }
    }

    // MARK: - Records

    func createRecord(result: RecordingResult) {
        let record = RealmRecord()

        record.patter = patter
        record.createdAt = Date()

        if let url = result.fileURL {
            record.url = url.absoluteString
        }

        if let duration = result.duration {
            record.duration = duration
        }

        try! realm.write {
            patter.records.append(record)
        }
    }

    func deleteRecord(at index: Int) {
        fileService.deleteIfExists(atPath: URL(string: records[index].url)!.path)

        try! realm.write {
            records.remove(at: index)
        }
    }

    func changeStarredForRecord(at index: Int, to isStarred: Bool) {
        let record = records[index]

        try! realm.write {
            record.isStarred = isStarred
            realm.add(record, update: true)
        }
    }

}
