//
//  AudioFilenameDefaultService.swift
//  Patter
//
//  Created by Maksim Ivanov on 13/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

final class AudioFilenameTimestampService: AudioFilenameService {

    func createFilename(filetype: Filetype) -> String {
        return "\(makeTimeStamp()).\(filetype.rawValue)"
    }

    private func makeTimeStamp() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyyMMddHHmmssSSSS"

        return dateFormatter.string(from: date)
    }

}
