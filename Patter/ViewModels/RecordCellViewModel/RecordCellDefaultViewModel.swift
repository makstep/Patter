//
//  RecordCellDefaultViewModel.swift
//  Patter
//
//  Created by Maksim Ivanov on 10/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import UIKit

final class RecordCellDefaultViewModel: RecordCellViewModel {

    // MARK: - Configurations

    typealias StrAttrs = [NSAttributedString.Key: Any]

    private static let dateAttributes: StrAttrs = [.font: UIFont.systemFont(ofSize: 10, weight: .regular)]
    private static let timeAttributes: StrAttrs = [.font: UIFont.systemFont(ofSize: 10, weight: .medium)]

    // MARK: - Private fields

    private let indexPath: IndexPath
    private let originDate: Date
    private let originDuration: Int
    private let isStarred: Bool

    private var date: NSAttributedString {
        return NSAttributedString(string: dateFormatter.string(from: originDate),
                                  attributes: RecordCellDefaultViewModel.dateAttributes)
    }

    private var time: NSAttributedString {
        return NSAttributedString(string: " \(timeFormatter.string(from: originDate))",
                                  attributes: RecordCellDefaultViewModel.timeAttributes)
    }

    // MARK: - Public API

    var createdAt: NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        attributedString.append(date)
        attributedString.append(time)

        return attributedString
    }

    var duration: String {
        return "\(originDuration)s"
    }

    var starredImage: UIImage {
        if isStarred {
            return UIImage(named: "StarChecked")!
        } else {
            return UIImage(named: "Star")!
        }
    }

    func toggleIsStarred() {
        onIsStarredChanged?(!isStarred)
    }

    // MARK: - Formatters

    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter
    }()

    private let timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter
    }()

    // MARK: - Common

    var onIsStarredChanged: ((_ isStarred: Bool) -> Void)?

    init(indexPath: IndexPath, date: Date, isStarred: Bool, duration: Int) {
        self.indexPath = indexPath
        self.originDate = date
        self.isStarred = isStarred
        self.originDuration = duration
    }

}
