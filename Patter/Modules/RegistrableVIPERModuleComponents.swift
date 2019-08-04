//
//  RegistrableInContainer.swift
//  Patter
//
//  Created by Maksim Ivanov on 14/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import Swinject

protocol RegistrableVIPERModuleComponents {
    static func registerVIPERComponents(in container: Container)
}
