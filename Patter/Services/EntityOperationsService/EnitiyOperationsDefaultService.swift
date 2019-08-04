//
//  PatterOperations.swift
//  Patter
//
//  Created by Maksim Ivanov on 09/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import RealmSwift

final class EnitiyOperationsDefaultService: EnitiyOperationsService {

    private let realm = try! Realm()
    private let fileService: FileService

    init(fileService: FileService) {
        self.fileService = fileService
    }

    func createPatterWithName(_ name: String) {
        try! realm.write {
            let entity = RealmPatter()
            entity.name = name

            realm.add(entity)
        }
    }

    func deletePatter(id: String) {
        guard let realmPatter = realm.object(ofType: RealmPatter.self, forPrimaryKey: id) else {
            return
        }

        do {
            for record in realmPatter.records {
                try realm.write {
                    fileService.deleteIfExists(atPath: URL(string: record.url)!.path)
                    realm.delete(record)
                }
            }

            try realm.write {
                realm.delete(realmPatter)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}
