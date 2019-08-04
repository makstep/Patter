//
//  PanelView.swift
//  Patter
//
//  Created by Maksim Ivanov on 07/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

enum RecordButtonState {
    case initial
    case recording
}

protocol ControlPanelViewDelegate: class {
    func stateChanged(to state: RecordButtonState)
    func hideKeyboard()
}

final class ControlPanelView: UIView {

    // MARK: - Public API fields

    weak var delegate: ControlPanelViewDelegate?

    var state: RecordButtonState = .initial {
        didSet {
            switch state {
            case .initial:
                recordButton.setTitle("Record", for: .normal)
            case .recording:
                recordButton.setTitle("Stop", for: .normal)
            }
        }
    }

    var isHideKeyboardButtonHidden = false {
        didSet {
            if isHideKeyboardButtonHidden {
                hideKeyboardButton.removeFromSuperview()
            } else {
                stackView.addArrangedSubview(hideKeyboardButton)
            }
        }
    }

    // MARK: - Views

    private let recordButton = UIButton(type: .system)
    private let hideKeyboardButton = UIButton(type: .system)
    private let stackView = UIStackView(frame: .zero)

    private let recordImage = UIImage(named: "RecordIcon")!
    private let hideKeyboardImage = UIImage(named: "HideKeyboardArrow")!

    // MARK: - Common

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        setupStackView()
        setupHideKeyboardButton()
        setupRecordButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup methods

    private func setupStackView() {
        self.addSubview(stackView)

        stackView.fillSuperview()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally

        stackView.addArrangedSubview(recordButton)
    }

    private func setupRecordButton() {
        recordButton.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        recordButton.setTitleColor(UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.0), for: .normal)
        recordButton.semanticContentAttribute = .forceRightToLeft
        recordButton.setImage(recordImage.withRenderingMode(.alwaysOriginal), for: .normal)
        recordButton.imageEdgeInsets = .init(top: 0, left: 14, bottom: 0, right: 0)

        recordButton.setTitle("Record", for: .normal)

        recordButton.addTarget(self, action: #selector(handleRecord), for: .touchUpInside)
    }

    private func setupHideKeyboardButton() {
        hideKeyboardButton.setImage(hideKeyboardImage.withRenderingMode(.alwaysOriginal), for: .normal)
        hideKeyboardButton.imageEdgeInsets = .init(top: 4, left: 0, bottom: 0, right: 0)

        NSLayoutConstraint.activate([
            hideKeyboardButton.widthAnchor.constraint(equalToConstant: hideKeyboardImage.size.width + 40)
        ])

        hideKeyboardButton.addTarget(self, action: #selector(handleHideKeyboard), for: .touchUpInside)
    }

    private func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
    }

    // MARK: - Handlers

    @objc private func handleRecord(_ sender: Any) {
        switch state {
        case .initial:
            delegate?.stateChanged(to: .recording)
        case .recording:
            delegate?.stateChanged(to: .initial)
        }
    }

    @objc private func handleHideKeyboard(_ sender: Any) {
        delegate?.hideKeyboard()
    }

}
