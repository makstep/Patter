//
//  FirstAppLaunchSetter.swift
//  Patter
//
//  Created by Maksim Ivanov on 09/07/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import RealmSwift

private struct DecodablePatterStruct: Decodable {
    var name: String
    var text: String
}

final class FirstAppLaunchSetter: SubSetter {

    private let realm = try! Realm()
    private let config = ApplicationConfiguration()

    func setIfNeeded() {
        if config.wasAppLaunchedBefore == true { return }

        setPatters()
        config.wasAppLaunchedBefore = true
    }

    private func setPatters() {
        for patterData in loadDefaults() {
            let patter = RealmPatter()

            patter.name = patterData.name
            patter.text = patterData.text

            try! realm.write {
                realm.add(patter)
            }
        }
    }

    func loadData() -> Data {
        guard let filePath = Bundle.main.path(forResource: "DefaultPatters", ofType: "plist") else {
            fatalError("Couldn't find plist of DefaultPatters.plist name")
        }

        let url = URL(fileURLWithPath: filePath)

        do {
            return try Data(contentsOf: url)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func loadDefaults() -> [DecodablePatterStruct] {
        let data = loadData()
        let decoder = PropertyListDecoder()

        do {
            return try decoder.decode([DecodablePatterStruct].self, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}
