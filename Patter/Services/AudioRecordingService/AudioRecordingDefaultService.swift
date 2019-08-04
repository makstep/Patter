//
//  AudioRecordingDefaultService.swift
//  Patter
//
//  Created by Maksim Ivanov on 13/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import AVFoundation

struct RecordingResult {
    let successRecording: Bool
    let duration: Int?
    let fileURL: URL?
}

final class AudioRecordingDefaultService: NSObject, AudioRecordingService, AVAudioRecorderDelegate {

    private var audioRecorder: AVAudioRecorder!
    private let audioFilenameService: AudioFilenameService

    private(set) var result: RecordingResult?

    private static let recordingSettings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 12000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]

    init(audioFilenameService: AudioFilenameService) {
        self.audioFilenameService = audioFilenameService
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func recordAudio() -> Bool {
        let filename = audioFilenameService.createFilename(filetype: .m4a)
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)

        audioRecorder = try! AVAudioRecorder(url: fileURL,
                                             settings: AudioRecordingDefaultService.recordingSettings)
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()

        return audioRecorder.record()
    }

    func stopRecordind() {
        if audioRecorder.isRecording {
            let duration = Int(audioRecorder.currentTime)
            let fileUrl = audioRecorder.url

            audioRecorder.stop()
            self.result = .init(successRecording: true, duration: duration, fileURL: fileUrl)
        } else {
            self.result = .init(successRecording: false, duration: nil, fileURL: nil)
        }
    }

}
