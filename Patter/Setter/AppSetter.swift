//
//  AppInitialier.swift
//  Patter
//
//  Created by Maksim Ivanov on 09/07/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

class AppSetter: SetCollection {

    private let subsetters: [SubSetter] = [
        FirstAppLaunchSetter()
    ]

    func setup() {
        subsetters.forEach { $0.setIfNeeded() }
    }

}
