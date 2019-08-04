//
//  FilesService.swift
//  Patter
//
//  Created by Maksim Ivanov on 14/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol FileService: class {
    func existsOnDisk(atPath: String) -> Bool
    func deleteFile(atPath: String) -> Bool
    func deleteIfExists(atPath: String)
}
