//
//  PatterDefaultPresenter.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import UIKit

final class PatterDefaultPresenter: PatterPresenter {

    // MARK: - VIPER objects

    weak var view: PatterView!
    var interactor: PatterPresenterToInteractorProtocol!
    var router: PatterRouter!

    // MARK: - Formatters

    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

}

extension PatterDefaultPresenter: PatterViewToPresenterProtocol {

    // MARK: - Configuring and formating

    func configureView() {
        let patterData = interactor.getPatterData()

        view?.setPatterTextView(name: patterData.name, text: patterData.text)
        view?.updateRecordsTableView(records: interactor.getRecordsData())
    }

    func formatRecordDate(date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    // MARK: - Recording and player

    func playRecord(indexPath: IndexPath) {
        interactor.playRecord(at: indexPath.row)
    }

    func recordAudio() {
        interactor.askForRecordingPermission { (isPermitted) in
            DispatchQueue.main.async {
                if isPermitted {
                    self.interactor.recordPatterSpeach()

                    self.view?.forceNavigationItem(isLocked: true)
                    self.view?.setRecordingButtonState(to: .recording)
                } else {
                    self.router?.presentPermissionsAlert()
                }
            }
        }
    }

    func stopRecordingAudio() {
        interactor.stopRecordingPatterSpeach()

        view?.forceNavigationItem(isLocked: false)
        view?.updateRecordsTableView(records: interactor.getRecordsData())
        view?.setRecordingButtonState(to: .initial)
    }

    func starringChanged(indexPath: IndexPath, changedTo: Bool) {
        interactor.starringChanged(at: indexPath.row, changedTo: changedTo)
        view?.updateRecordsTableView(records: interactor.getRecordsData())
    }

    // MARK: - Realm entitie's operations

    func deleteRecord(indexPath: IndexPath) {
        interactor.deleteRecord(at: indexPath.row)
        view?.updateRecordsTableView(records: interactor.getRecordsData())
    }

    func nameChanged(string: String) {
        interactor.updateName(string)
    }

    func textChanged(string: String) {
        interactor.updateText(string)
    }

    func recordsCount() -> Int {
        return interactor.getRecordsData().count
    }

    func recordDataForIndex(indexPath: IndexPath) -> RecordData {
        return interactor.getRecordsData()[indexPath.row]
    }

}

extension PatterDefaultPresenter: PatterInteractorToPresenterProtocol {

    func notifyFileLost(at index: Int) {
        router.presentAlert(title: "File was lost", message: "Record will be deleted.") {
            self.deleteRecord(indexPath: IndexPath(row: index, section: 0))
        }
    }

    func updateTimer(timeIterval: TimeInterval) {
        let hours = String(format: "%02d", Int(timeIterval) / 3600)
        let minutes = String(format: "%02d", Int(timeIterval) / 60 % 60)
        let seconds = String(format: "%02d", Int(timeIterval) % 60)

        view?.updateTimer(to: "\(hours):\(minutes):\(seconds)")
    }

    func unfocusRecords() {
        view.unfocusRecords()
    }

}
