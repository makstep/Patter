//
//  PatterPresenterToInteractorProtocol.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol PatterPresenterToInteractorProtocol {
    func getPatterData() -> PatterData
    func getRecordsData() -> [RecordData]

    func updateName(_ name: String)
    func updateText(_ text: String)

    func askForRecordingPermission(callback: @escaping ((Bool) -> Void))
    func recordPatterSpeach()
    func stopRecordingPatterSpeach()

    func playRecord(at index: Int)
    func deleteRecord(at index: Int)
    func starringChanged(at index: Int, changedTo: Bool)
}
