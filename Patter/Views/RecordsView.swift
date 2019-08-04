//
//  RecordsTableView.swift
//  Patter
//
//  Created by Maksim Ivanov on 13/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import UIKit

protocol RecordsViewDelegate: class {
    func deleteRecord(indexPath: IndexPath)
    func playRecord(indexPath: IndexPath)
    func starringChanged(indexPath: IndexPath, changedTo: Bool)
}

final class RecordsView: UIView {

    private var tableView = UITableView()
    private var noRecordsLabel = UILabel()
    private var timer: Timer?

    var recordsData: [RecordData] = [] {
        didSet {
            updateView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    weak var delegate: RecordsViewDelegate?

    func unfocusRecords() {
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }

    private func setUpView() {
        addSubview(tableView)
        addSubview(noRecordsLabel)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(RecordCell.self, forCellReuseIdentifier: RecordCell.reuseID)

        noRecordsLabel.text = "No Records"
        noRecordsLabel.textAlignment = .center
        noRecordsLabel.font = UIFont.systemFont(ofSize: 18)
        noRecordsLabel.textColor = #colorLiteral(red: 0.5524711013, green: 0.5489741564, blue: 0.5358634591, alpha: 1)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        noRecordsLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            noRecordsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noRecordsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            noRecordsLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: 0.8),
            noRecordsLabel.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        updateView()
    }

    private func updateView() {
        if recordsData.isEmpty {
            noRecordsLabel.isHidden = false
            tableView.isHidden = true
        } else {
            noRecordsLabel.isHidden = true
            tableView.isHidden = false
        }

        tableView.reloadData()
    }
}

extension RecordsView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.deleteRecord(indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.playRecord(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }

}

extension RecordsView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordsData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordCell.reuseID) as? RecordCell else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }

        let recordData = recordsData[indexPath.row]

        let viewModel = RecordCellDefaultViewModel(indexPath: indexPath,
                                                   date: recordData.createdAt!,
                                                   isStarred: recordData.isStarred,
                                                   duration: recordData.duration)
        viewModel.onIsStarredChanged = { [weak self] (nextIsStarred) in
            self?.delegate?.starringChanged(indexPath: indexPath, changedTo: nextIsStarred)
        }

        cell.viewModel = viewModel

        return cell
    }

}
