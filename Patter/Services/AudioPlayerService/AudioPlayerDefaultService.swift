//
//  AudioPlayerDefaultService.swift
//  Patter
//
//  Created by Maksim Ivanov on 14/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import AVFoundation

final class AudioPlayerDefaultService: AudioPlayerService {

    weak var delegate: AudioPlayerServiceDelegate?

    private let player = AVQueuePlayer()

    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playingFinished),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        player.removeAllItems()
    }

    func play(url: URL) {
        let playerItem = AVPlayerItem(url: url)

        player.removeAllItems()
        player.insert(playerItem, after: nil)

        player.play()
    }

    @objc private func playingFinished() {
        delegate?.onAudioFinish()
    }

}
