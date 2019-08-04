//
//  EachSecondCountService.swift
//  Patter
//
//  Created by Maksim Ivanov on 14/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

//class EachSecondDefaultService: CountService {
//
//    // MARK: - Private fields
//
//    private var timerStartedAt: Date?
//    private var timer: Timer?
//    private let countEach: TimeInterval
//
//    // MARK: - Init
//
//    init(countEach: Int) {
//        self.countEach = TimeInterval(exactly: Double(countEach))!
//    }
//
//    deinit {
//        stop()
//    }
//
//    // MARK: - Public API
//
//    var onTick: ((TimeInterval) -> Void)?
//
//    func start() {
//        stop()
//        timer = Timer.scheduledTimer(timeInterval: 1.0,
//                                     target: self,
//                                     selector: #selector(onTinerTick),
//                                     userInfo: nil,
//                                     repeats: true)
//        RunLoop.current.add(timer!, forMode: .common)
//        self.timerStartedAt = Date()
//    }
//
//    func stop() {
//        timer?.invalidate()
//        self.timer = nil
//        self.timerStartedAt = nil
//    }
//
//    // MARK: - Private methods
//
//    @objc private func onTinerTick() {
////        onTick?(tickCount)
//    }
//
//}
