//
//  PatterBuilder.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import UIKit

protocol PatterBuilder {
    func buildPatterModule(patterId: String) -> UIViewController?
}
