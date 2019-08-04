//
//  PatterRoute.swift
//  Patter
//
//  Created by Maksim Ivanov on 15/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol PatterRouter {
    func presentAlert(title: String?, message: String?, onDismiss: @escaping (() -> Void))
    func presentPermissionsAlert()
}
