//
//  PatterView.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol PatterView: class {
    func setPatterTextView(name: String, text: String)

    func setRecordingButtonState(to newState: RecordButtonState)
    func updateRecordsTableView(records: [RecordData])
    func forceNavigationItem(isLocked: Bool)
    func updateTimer(to stringTime: String)
    func unfocusRecords()
}
