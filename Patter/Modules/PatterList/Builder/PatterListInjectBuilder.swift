//
//  PatterListInjectBuilder.swift
//  Patter
//
//  Created by Maksim Ivanov on 12/04/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation
import Swinject
import UIKit

final class PatterListInjectBuilder: PatterListBuilder, RegistrableVIPERModuleComponents {

    func buildPatterListModule() -> UIViewController? {
        return Container.sharedContainer.resolve(PatterListView.self) as? UIViewController
    }

    static func registerVIPERComponents(in container: Container) {
            registerView(container: container)
            registerInteractor(container: container)
            registerRouter(container: container)
            registerPresenter(container: container)
    }

    private static func registerView(container: Container) {
        let viewDescription = container.register(PatterListView.self) { _ in
            let controller = UIStoryboard(name: "Main",
                                          bundle: nil).instantiateViewController(withIdentifier: "patterList")
            return controller as! PatterListViewController
        }

        viewDescription.initCompleted { (resolver, view) in
            let view = view as! PatterListViewController
            view.presenter = resolver.resolve(PatterListPresenter.self)
        }
    }

    private static  func registerInteractor(container: Container) {
        let interactorDescription = container.register(PatterListInteractor.self) { (resolver) in
            PatterListDefaultInteractor(
                patterListService: resolver.resolve(PatterListService.self)!,
                entityOperationsService: resolver.resolve(EnitiyOperationsService.self)!
            )
        }
        interactorDescription.initCompleted { (resolver, interactor) in
            let interactor = interactor as! PatterListDefaultInteractor
            interactor.presenter = resolver.resolve(PatterListPresenter.self)
        }
    }

    private static  func registerRouter(container: Container) {
        let routerDescription = container.register(PatterListRouter.self) { (resolver) in
            PatterListDefaultRouter(viewController: (resolver.resolve(PatterListView.self) as? UIViewController)!)
        }
        routerDescription.initCompleted { (resolver, router) in
            let router = router as! PatterListDefaultRouter
            router.presenter = resolver.resolve(PatterListPresenter.self)!
        }
    }

    private static func registerPresenter(container: Container) {
        container.register(PatterListPresenter.self) { (resolver) in
            PatterListDefaultPresenter(interactor: resolver.resolve(PatterListInteractor.self)!,
                                       router: resolver.resolve(PatterListRouter.self)!,
                                       view: resolver.resolve(PatterListView.self)!)
        }

    }

}
