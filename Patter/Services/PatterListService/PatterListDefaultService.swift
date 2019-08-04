//
//  PatterListDefaultService.swift
//  Patter
//
//  Created by Maksim Ivanov on 14/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import RealmSwift

final class PatterListDefaultService: PatterListService {

    private let realm = try! Realm()
    private var notificationToken: NotificationToken?

    private var entities: Results<RealmPatter>!

    init() {
        self.entities = getDefaultScope()
        setObservation()
    }

    deinit {
        removeObservation()
    }

    // MARK: - Public API

    weak var delegate: PatterListServiceDelegate?

    func getDataEntities() -> [PatterData] {
        return entities.map { $0.transferData }
    }

    func filterByName(_ name: String) {
        removeObservation()

        if name.isEmpty {
            entities = getDefaultScope()
        } else {
            entities = getDefaultScope().filter("name CONTAINS[cd] '\(name)'")
        }

        setObservation()
    }

    // MARK: - Private

    private func setObservation() {
        notificationToken = entities.observe { (changes: RealmCollectionChange<Results<RealmPatter>>) in
            if case .initial(_) = changes {
                self.delegate?.reloadEntities()
            }

            if case let .update(_, deletions, insertions, modifications) = changes {
                self.delegate?.changed(deletions: deletions,
                                       insertions: insertions,
                                       modifications: modifications)
            }
        }
    }

    private func removeObservation() {
        notificationToken?.invalidate()
    }

    private func getDefaultScope() -> Results<RealmPatter> {
        return realm.objects(RealmPatter.self).sorted(byKeyPath: "createdAt")
    }

}
