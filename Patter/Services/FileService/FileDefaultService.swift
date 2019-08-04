//
//  FileChecker.swift
//  Patter
//
//  Created by Maksim Ivanov on 09/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

final class FileDefaultService: FileService {

    private let fileManager = FileManager()

    func existsOnDisk(atPath: String) -> Bool {
        return fileManager.fileExists(atPath: atPath)
    }

    @discardableResult
    func deleteFile(atPath: String) -> Bool {
        if fileManager.isDeletableFile(atPath: atPath) {
            do {
                try fileManager.removeItem(atPath: atPath)
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }

    func deleteIfExists(atPath: String) {
        if existsOnDisk(atPath: atPath) {
            deleteFile(atPath: atPath)
        }
    }

}
