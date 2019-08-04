//
//  CountService.swift
//  Patter
//
//  Created by Maksim Ivanov on 14/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol CountService: class {
    var onTick: ((_ timeInterval: TimeInterval) -> Void)? { get set }

    func start()
    func stop()
}
