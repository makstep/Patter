//
//  PatterListDefaultRouter.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import Swinject
import UIKit

final class PatterListDefaultRouter: PatterListRouter {

    private weak var viewController: UIViewController?
    weak var presenter: PatterListPresenter?

    let storyBoard = UIStoryboard(name: "Main", bundle: nil)

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func navigateToPatter(id: String) {
        guard let navigationController = self.viewController?.navigationController else { return }
        guard let builder = Container.sharedContainer.resolve(PatterBuilder.self) else { return }
        guard let viewController = builder.buildPatterModule(patterId: id) else { return }

        navigationController.pushViewController(viewController, animated: true)
    }

    func presentConfirmDeleteAlert(indexPath: IndexPath, patterName: String) {
        let message = "This patter will be deleted. This action cannot be undone."
        let alertController = UIAlertController(title: patterName, message: message, preferredStyle: .actionSheet)

        let confirmAction = UIAlertAction(title: "Erise", style: .destructive) { _ in
            self.presenter?.delete(indexPath: indexPath)
        }

        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.viewController?.present(alertController, animated: true)
    }

    func presentNewPatterFormAlert() {
        let alertController = UIAlertController(title: "New Patter",
                                                message: "Please, input name",
                                                preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "name"
        }

        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let textField = alertController.textFields?.first else { return }
            guard let name = textField.text else { return }

            self.presenter?.addPatter(name: name)
        }

        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.viewController?.present(alertController, animated: true)
    }

}
