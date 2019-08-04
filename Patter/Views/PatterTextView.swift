//
//  PatterView.swift
//  Patter
//
//  Created by Maksim Ivanov on 11/03/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

protocol PatterStringFieldsChangeDelegate: class {
    func nameChanged(string: String)
    func textChanged(string: String)
}

final class PatterTextView: UIView {

    // MARK: - Views

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let nameTextView = UIPlaceHolderTextView()
    private let bodyTextView = UIPlaceHolderTextView()

    // MARK: - Confugutarion

    private let scrollViewBottomMargin = CGFloat(0)

    private let defaultAttributedStringAttributes: [NSAttributedString.Key: Any] = {
        let mutableParagraphStyle = NSMutableParagraphStyle()
        mutableParagraphStyle.lineSpacing = CGFloat(3)

        return [.font: UIFont.preferredFont(forTextStyle: .body),
                .paragraphStyle: mutableParagraphStyle]
    }()

    weak var delegate: PatterStringFieldsChangeDelegate?

    var name: String = "" {
        didSet {
            nameTextView.text = name
        }
    }
    var body: String = "" {
        didSet {
            bodyTextView.attributedText = NSMutableAttributedString(string: body,
                                                                    attributes: defaultAttributedStringAttributes)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = .white

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        nameTextView.translatesAutoresizingMaskIntoConstraints = false
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false

        nameTextView.isScrollEnabled = false
        bodyTextView.isScrollEnabled = false

        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(nameTextView)
        contentView.addSubview(bodyTextView)

        nameTextView.delegate = self
        bodyTextView.delegate = self

        nameTextView.placeholder = "Name"
        bodyTextView.placeholder = "Patter Body ....."

        nameTextView.placeholderColor = .lightGray
        bodyTextView.placeholderColor = .lightGray

        setUpLayouts()
        setTextViewsStyles()
    }

    private func setTextViewsStyles() {
        nameTextView.font = UIFont.preferredFont(forTextStyle: .title1)
        bodyTextView.font = UIFont.preferredFont(forTextStyle: .body)

        nameTextView.textContainerInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        bodyTextView.textContainerInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }

    private func setUpLayouts() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                               constant: -scrollViewBottomMargin)
        ])

        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            nameTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 20),
            bodyTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bodyTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])

        contentView.bottomAnchor.constraint(equalTo: bodyTextView.bottomAnchor, constant: 20).isActive = true
    }

}

extension PatterTextView: UITextViewDelegate {

    public func textViewDidChange(_ textView: UITextView) {
        if textView == nameTextView {
            delegate?.nameChanged(string: textView.text)
        } else if textView == bodyTextView {
            delegate?.textChanged(string: textView.attributedText.string)
        }
    }

}
