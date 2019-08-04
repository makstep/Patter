//
//  PatterEntityService.swift
//  Patter
//
//  Created by Maksim Ivanov on 09/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmPatterEntityService: class {

    var patter: RealmPatter { get }
    var records: List<RealmRecord> { get }

    // MARK: - Patter fields

    func changeName(_ name: String)
    func changeText(_ text: String)

    // MARK: - Records

    func createRecord(result: RecordingResult)
    func deleteRecord(at index: Int)
    func changeStarredForRecord(at index: Int, to isStarred: Bool)

}
