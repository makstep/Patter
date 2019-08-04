//
//  PatterViewToPresenter.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol PatterViewToPresenterProtocol {
    func configureView()

    func nameChanged(string: String)
    func textChanged(string: String)

    func recordsCount() -> Int
    func recordDataForIndex(indexPath: IndexPath) -> RecordData

    func formatRecordDate(date: Date) -> String

    func recordAudio()
    func stopRecordingAudio()

    func playRecord(indexPath: IndexPath)
    func deleteRecord(indexPath: IndexPath)
    func starringChanged(indexPath: IndexPath, changedTo: Bool)
}
