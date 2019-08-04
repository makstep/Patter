//
//  RecordingTimeLabel.swift
//  Patter
//
//  Created by Maksim Ivanov on 10/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

final class RecordingTimeLabel: UILabel {

    private let hiddenHeight: CGFloat = 0
    private let fullHeight: CGFloat = 20

    private var heightAnchorConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.systemFont(ofSize: 16, weight: .light)
        self.textAlignment = .center
        self.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.0)
        self.text = "00:00:00"

        self.heightAnchorConstraint = heightAnchor.constraint(equalToConstant: hiddenHeight)
        self.heightAnchorConstraint.isActive = true
    }

    func slideUpIfNeeded() {
        if heightAnchorConstraint.constant == hiddenHeight {
            self.heightAnchorConstraint.constant = fullHeight
        }
    }

}
