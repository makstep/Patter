//
//  AudioPlayerService.swift
//  Patter
//
//  Created by Maksim Ivanov on 14/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol AudioPlayerServiceDelegate: class {
    func onAudioFinish()
}

protocol AudioPlayerService: class {
    var delegate: AudioPlayerServiceDelegate? { get set }

    func play(url: URL)
}
