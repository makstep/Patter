//
//  StringFilenameFactory.swift
//  Patter
//
//  Created by Maksim Ivanov on 17/03/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

enum Filetype: String {
    case m4a
}

protocol AudioFilenameService: class {
    func createFilename(filetype: Filetype) -> String
}
