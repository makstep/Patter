//
//  VibrationDefaultService.swift
//  Patter
//
//  Created by Maksim Ivanov on 13/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import AVFoundation

final class VibrationDefaultService: VibrationService {

    private let peekSoundID = SystemSoundID(1519)
    private let popSoundID = SystemSoundID(1520)

    func onRecordVebration() {
        AudioServicesPlaySystemSound(peekSoundID)
    }

    func onStopRecordingVibration() {
        AudioServicesPlaySystemSound(popSoundID)
    }

}
