//
//  ShowPatterViewController.swift
//  Patter
//
//  Created by Maksim Ivanov on 07/03/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

private enum PatterSegmentedControllStates: Int {
    case text = 0
    case records = 1

    static func items() -> [String] {
        return ["Text", "Records"]
    }
}

final class PatterViewController: UIViewController {

    // MARK: - VIPER objects

    var presenter: PatterViewToPresenterProtocol!

    // MARK: - Constraints

    private var textSectionStackViewBottomConstraint: NSLayoutConstraint!

    // MARK: - Views

    private let textSectionStackView = UIStackView(frame: .zero)
    private let controlPanelView = ControlPanelView()
    private let segmentedControl: UISegmentedControl = UISegmentedControl(items: PatterSegmentedControllStates.items())
    private let patterView = PatterTextView()
    private let recordsView = RecordsView()
    private let recordingTimeLabel = RecordingTimeLabel()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.configureView()

        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)

        setupTextSectionStackView()
        setupNavigationItem()
        setupRecordView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardEvents()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // swiftlint:disable notification_center_detachment
        NotificationCenter.default.removeObserver(self)
        // swiftlint:enable notification_center_detachment
    }

    @objc func segmentChanged(sender: UISegmentedControl) {
        guard let state = PatterSegmentedControllStates(rawValue: segmentedControl.selectedSegmentIndex) else { return }

        switch state {
        case .text:
            textSectionStackView.isHidden = false
            recordsView.isHidden = true

            animateSlide(view: textSectionStackView, from: CGAffineTransform(translationX: -view.frame.width, y: 0))
        case .records:
            textSectionStackView.isHidden = true
            recordsView.isHidden = false

            animateSlide(view: recordsView, from: CGAffineTransform(translationX: view.frame.width * 2, y: 0))
            view.endEditing(true)
        }
    }

    private func animateSlide(view: UIView, from: CGAffineTransform) {
        view.transform = from

        UIView.animate(withDuration: 0.09,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: { view.transform = .identity },
                       completion: nil)
    }

    // MARK: - Setups

    private func setupTextSectionStackView() {
        textSectionStackView.axis = .vertical
        textSectionStackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(textSectionStackView)

        NSLayoutConstraint.activate([
            textSectionStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textSectionStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            textSectionStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])

        textSectionStackViewBottomConstraint =
            textSectionStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        textSectionStackViewBottomConstraint.isActive = true

        textSectionStackView.addArrangedSubview(patterView)
        textSectionStackView.addArrangedSubview(controlPanelView)
        textSectionStackView.addArrangedSubview(recordingTimeLabel)

        controlPanelView.delegate = self

        controlPanelView.heightAnchor.constraint(equalToConstant: 46).isActive = true
    }

    private func setupNavigationItem() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0

        navigationItem.titleView = segmentedControl
    }

    private func setupRecordView() {
        recordsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recordsView)

        recordsView.isHidden = true
        recordsView.delegate = self

        NSLayoutConstraint.activate([
            recordsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recordsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            recordsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recordsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Keyboard

    private func subscribeToKeyboardEvents() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardNotification),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardNotification),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc private func handleKeyboardNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardFrame = value.cgRectValue
        let willKeyboardShow = notification.name == UIResponder.keyboardWillShowNotification

        let constant = willKeyboardShow ? -keyboardFrame.height + view.safeAreaInsets.bottom : 0
        textSectionStackViewBottomConstraint?.constant = constant
        controlPanelView.isHideKeyboardButtonHidden = !willKeyboardShow

        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }

}

// MARK: API called by the presenter

extension PatterViewController: PatterView {

    func unfocusRecords() {
        recordsView.unfocusRecords()
    }

    func updateTimer(to stringTime: String) {
        recordingTimeLabel.text = stringTime
    }

    func forceNavigationItem(isLocked: Bool) {
        UIView.animate(withDuration: 0.15) {
            if isLocked {
                self.segmentedControl.isEnabled = false
                self.navigationItem.setHidesBackButton(true, animated: true)
            } else {
                self.segmentedControl.isEnabled = true
                self.navigationItem.setHidesBackButton(false, animated: true)
            }
        }
    }

    func updateRecordsTableView(records: [RecordData]) {
        recordsView.recordsData = records
    }

    func setRecordingButtonState(to newState: RecordButtonState) {
        controlPanelView.state = newState
    }

    func setPatterTextView(name: String, text: String) {
        patterView.name = name
        patterView.body = text

        patterView.delegate = self
    }

}

// MARK: - ControlPanel delegate

extension PatterViewController: ControlPanelViewDelegate {

    func stateChanged(to state: RecordButtonState) {
        switch state {
        case .initial:
            presenter.stopRecordingAudio()
        case .recording:
            recordingTimeLabel.slideUpIfNeeded()
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }

            presenter.recordAudio()
        }
    }

    func hideKeyboard() {
        self.view.endEditing(true)
        controlPanelView.isHideKeyboardButtonHidden = true
    }

}

// MARK: - Patters text fields delegate

extension PatterViewController: PatterStringFieldsChangeDelegate {

    func nameChanged(string: String) {
        presenter.nameChanged(string: string)
    }

    func textChanged(string: String) {
        presenter.textChanged(string: string)
    }

}

// MARK: - Records table delegate

extension PatterViewController: RecordsViewDelegate {

    func starringChanged(indexPath: IndexPath, changedTo: Bool) {
        presenter.starringChanged(indexPath: indexPath, changedTo: changedTo)
    }

    func deleteRecord(indexPath: IndexPath) {
        presenter.deleteRecord(indexPath: indexPath)
    }

    func playRecord(indexPath: IndexPath) {
        presenter.playRecord(indexPath: indexPath)
    }

}
