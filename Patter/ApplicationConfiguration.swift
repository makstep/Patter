//
//  ApplicationConfiguration.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

enum ConfigKey: String {
    case wasAppLaunchedBefore
}

class ApplicationConfiguration {

    private let store = UserDefaults.standard

    var wasAppLaunchedBefore: Bool {
        set {
            store.set(newValue, forKey: ConfigKey.wasAppLaunchedBefore.rawValue)
        }

        get {
            return store.bool(forKey: ConfigKey.wasAppLaunchedBefore.rawValue)
        }
    }

    init() {
        store.register(defaults: [
            ConfigKey.wasAppLaunchedBefore.rawValue: false
        ])
    }

}
