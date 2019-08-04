//
//  RecordCell.swift
//  Patter
//
//  Created by Maksim Ivanov on 15/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {

    static let reuseID = "RecordCell"

    var viewModel: RecordCellViewModel! {
        didSet {
            self.createdAtLabel.attributedText = viewModel.createdAt
            self.starButton.setImage(viewModel.starredImage.withRenderingMode(.alwaysOriginal), for: .normal)
            self.durationLabel.text = viewModel.duration
        }
    }

    private let stackView = UIStackView()
    private let timeStackView = UIStackView()
    private let createdAtLabel = UILabel()
    private let starButton = UIButton()
    private let durationLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(stackView)

        stackView.preservesSuperviewLayoutMargins = true
        stackView.isLayoutMarginsRelativeArrangement = true

        stackView.fillSuperview()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally

        timeStackView.axis = .vertical
        timeStackView.distribution = .fillEqually

        stackView.addArrangedSubview(timeStackView)

        timeStackView.addArrangedSubview(durationLabel)
        timeStackView.addArrangedSubview(createdAtLabel)

        stackView.addArrangedSubview(starButton)

        starButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        starButton.addTarget(self, action: #selector(starredButtonPressed), for: .touchUpInside)
    }

    @objc private func starredButtonPressed(_ sender: Any) {
        viewModel.toggleIsStarred()
    }

}
