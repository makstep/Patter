//
//  RecordCellViewModel.swift
//  Patter
//
//  Created by Maksim Ivanov on 10/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import UIKit

protocol RecordCellViewModel {
    var createdAt: NSMutableAttributedString { get }
    var starredImage: UIImage { get }
    var duration: String { get }

    func toggleIsStarred()
}
