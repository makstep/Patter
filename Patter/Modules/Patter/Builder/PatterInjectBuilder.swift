//
//  PatterInjectBuilder.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import Swinject
import UIKit

final class PatterInjectBuiler: PatterBuilder, RegistrableVIPERModuleComponents {

    func buildPatterModule(patterId: String) -> UIViewController? {
        let container = Container.sharedContainer

        let realmPatterEntityService = container.resolve(RealmPatterEntityService.self, argument: patterId)!
        let patterViewController = container.resolve(PatterView.self) as! PatterViewController

        let pressenter = patterViewController.presenter as! PatterDefaultPresenter
        let interactor = pressenter.interactor as! PatterDefaultInteractor

        interactor.realmPatterEntityService = realmPatterEntityService

        return patterViewController
    }

    static func registerVIPERComponents(in container: Container) {
        registerView(container: container)
        registerInteractor(container: container)
        registerPresenter(container: container)
        registerRouter(container: container)
    }

    private static func registerView(container: Container) {
        let viewDescription = container.register(PatterView.self) { _ in
            let controller =
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showPatter")
            return controller as! PatterViewController
        }

        viewDescription.initCompleted { (resolver, view) in
            let view = view as! PatterViewController
            view.presenter = resolver.resolve(PatterPresenter.self)!
        }
    }

    private static func registerInteractor(container: Container) {
        let interactorDescription = container.register(PatterInteractor.self) { (resolver) in
            PatterDefaultInteractor(audioRecordingService: resolver.resolve(AudioRecordingService.self)!,
                                    audioPlayerService: resolver.resolve(AudioPlayerService.self)!,
                                    vibrationService: resolver.resolve(VibrationService.self)!)
        }
        interactorDescription.initCompleted { (resolver, interactor) in
            let presenter = resolver.resolve(PatterPresenter.self)!
            let interactor = interactor as! PatterDefaultInteractor

            interactor.presenter = presenter
        }
    }

    private static func registerPresenter(container: Container) {
        let presenterDescription = container.register(PatterPresenter.self) { _ in
            PatterDefaultPresenter()
        }

        presenterDescription.initCompleted { (resolver, presenter) in
            let presenter = presenter as! PatterDefaultPresenter

            presenter.view = resolver.resolve(PatterView.self)!
            presenter.interactor = resolver.resolve(PatterInteractor.self)!
            presenter.router = resolver.resolve(PatterRouter.self)!
        }
    }

    private static func registerRouter(container: Container) {
        let routerDescription = container.register(PatterRouter.self) { (_) in
            PatterDefaultRouter()
        }

        routerDescription.initCompleted { (resolver, router) in
            let router = router as! PatterDefaultRouter

            router.viewController = resolver.resolve(PatterView.self)! as? UIViewController
            router.presenter = resolver.resolve(PatterPresenter.self)!
        }
    }

}
