//
//  RecordAudioManager.swift
//  Patter
//
//  Created by Maksim Ivanov on 16/03/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol AudioRecordingService: class {

    typealias FilepathURL = URL

    var result: RecordingResult? { get }

    func recordAudio() -> Bool
    func stopRecordind()

}
