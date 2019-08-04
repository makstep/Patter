//
//  PatterDefaultInteractor.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import AVFoundation

final class PatterDefaultInteractor: PatterInteractor {

    // MARK: - VIPER objects

    weak var presenter: PatterInteractorToPresenterProtocol?

    // MARK: - Services

    private let audioSession = AVAudioSession.sharedInstance()

    private let audioRecordingService: AudioRecordingService
    private let audioPlayerService: AudioPlayerService
    private let vibrationService: VibrationService

    var realmPatterEntityService: RealmPatterEntityService!

    // MARK: - Private Variables

    private var timerStartedAt: Date?
    private var timer: Timer?

    // MARK: - Default

    init(audioRecordingService: AudioRecordingService,
         audioPlayerService: AudioPlayerService,
         vibrationService: VibrationService) {
        self.audioRecordingService = audioRecordingService
        self.audioPlayerService = audioPlayerService
        self.vibrationService = vibrationService

        audioPlayerService.delegate = self

        try! audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
    }

    // MARK: - Timer

    private func setupTimer() {
        removeTimer()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
        self.timerStartedAt = Date()
    }

    private func removeTimer() {
        timer?.invalidate()
        self.timer = nil
        self.timerStartedAt = nil
    }

    @objc private func updateTimer() {
        let timeIterval = Date().timeIntervalSince(timerStartedAt!)
        presenter?.updateTimer(timeIterval: timeIterval)
    }

}

extension PatterDefaultInteractor: PatterPresenterToInteractorProtocol {

    // MARK: - Permissions

    func askForRecordingPermission(callback: @escaping ((Bool) -> Void)) {
        AVAudioSession.sharedInstance().requestRecordPermission { (isPermitted) in
            callback(isPermitted)
        }
    }

    // MARK: - Realm entitie's operations

    func updateName(_ name: String) {
        realmPatterEntityService.changeName(name)
    }

    func updateText(_ text: String) {
        realmPatterEntityService.changeText(text)
    }

    func getRecordsData() -> [RecordData] {
        return realmPatterEntityService.records.map { $0.transferData }
    }

    func getPatterData() -> PatterData {
        return realmPatterEntityService.patter.transferData
    }

    func deleteRecord(at index: Int) {
        realmPatterEntityService.deleteRecord(at: index)
    }

    func starringChanged(at index: Int, changedTo: Bool) {
        realmPatterEntityService.changeStarredForRecord(at: index, to: changedTo)
    }

    // MARK: - Recording and player

    func recordPatterSpeach() {
        vibrationService.onRecordVebration()

        if audioRecordingService.recordAudio() {
            setupTimer()
        } else {
            print("Fail to start recording")
        }
    }

    func stopRecordingPatterSpeach() {
        audioRecordingService.stopRecordind()
        vibrationService.onStopRecordingVibration()

        guard let result = audioRecordingService.result else {
            print("Audio result not found")
            return
        }

        if result.successRecording {
            realmPatterEntityService.createRecord(result: result)
        } else {
            print("Recording was not successful")
        }

        removeTimer()
    }

    func playRecord(at index: Int) {
        let record = realmPatterEntityService.records[index]
        let url = URL(string: record.url)!

        if !FileDefaultService().existsOnDisk(atPath: url.path) {
            print("Record's file was stolen by NLO")
            // Or even make and alert
            presenter?.notifyFileLost(at: index)
            presenter?.unfocusRecords()
            return
        }

        audioPlayerService.play(url: url)
    }

}

// MARK: - Audio Player Service Delegate

extension PatterDefaultInteractor: AudioPlayerServiceDelegate {

    func onAudioFinish() {
        presenter?.unfocusRecords()
    }

}
