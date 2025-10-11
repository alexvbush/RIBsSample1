//
//  RootRouter.swift
//  RIBsSample1
//
//  Created by Alex Bush on 10/11/25.
//

import RIBs
import UIKit

protocol RootInteractable: Interactable, FirstRIBListener {
    nonisolated var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func embedFirstRIBViewController(_ viewController: UIViewController)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let firstRIBBuilder: FirstRIBBuildable
    private var firstRIBRouter: FirstRIBRouting?

    init(interactor: RootInteractable, viewController: RootViewControllable,
         firstRIBBuilder: FirstRIBBuildable) {
        self.firstRIBBuilder = firstRIBBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        routeToFirstRIB()
    }
    
    private func routeToFirstRIB() {
        let firstRIBRouter = firstRIBBuilder.build(withListener: interactor)
        self.firstRIBRouter = firstRIBRouter
        nonisolated(unsafe) let firstRIBViewControllable = firstRIBRouter.viewControllable
        nonisolated(unsafe) let viewController = self.viewController
        Task { @MainActor in
            viewController.embedFirstRIBViewController(firstRIBViewControllable.uiviewController)
        }
        attachChild(firstRIBRouter)
    }
}
