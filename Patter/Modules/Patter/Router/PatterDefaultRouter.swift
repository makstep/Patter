//
//  PatterDefaultRouter.swift
//  Patter
//
//  Created by Maksim Ivanov on 15/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

final class PatterDefaultRouter: PatterRouter {

    weak var viewController: UIViewController?
    weak var presenter: PatterPresenter?

    func presentAlert(title: String?, message: String?, onDismiss: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "I have read it", style: .default) { _ in
            onDismiss()
        }

        alert.addAction(okeyAction)

        self.viewController?.present(alert, animated: true)
    }

    func presentPermissionsAlert() {
        let problem = "The Patter App does not have access to Microphone."
        let solution = "To enable access, tap Settings and turn on Microphone."

        let alertController = UIAlertController(
            title: "\(problem) \(solution)",
            message: nil,
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            self.openAppSettings()
        }))

        self.viewController?.present(alertController, animated: true)
    }

    private func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

}
