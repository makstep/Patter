//
//  AllPattersRouter.swift
//  Patter
//
//  Created by Maksim Ivanov on 27/03/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol PatterListRouter: class {
    func navigateToPatter(id: String)

    // Alert Controllers
    func presentConfirmDeleteAlert(indexPath: IndexPath, patterName: String)
    func presentNewPatterFormAlert()
}
