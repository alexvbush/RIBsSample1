//
//  FirstRIBRouter.swift
//  RIBsSample1
//
//  Created by Alex Bush on 9/27/25.
//

import RIBs
import UIKit

protocol FirstRIBInteractable: Interactable, SecondRIBListener, ThirdRIBListener {
    nonisolated var router: FirstRIBRouting? { get set }
    var listener: FirstRIBListener? { get set }
}

protocol FirstRIBViewControllable: ViewControllable, SecondRIBViewControllable {
    func attachThirRIBViewController(_ viewController: UIViewController)
}

final class FirstRIBRouter: ViewableRouter<FirstRIBInteractable, FirstRIBViewControllable>, FirstRIBRouting {
    
    private let secondRIBBuilder: SecondRIBBuildable
    private var secondRIBRouter: SecondRIBRouting?
    
    private let thirdRIBBuilder: ThirdRIBBuildable
    private var thirdRIBRouter: ThirdRIBRouting?
    
    var firstRIBViewControllable: FirstRIBViewControllable {
        viewController
    }

    init(interactor: FirstRIBInteractable, viewController: FirstRIBViewControllable,
         secondRIBBuilder: SecondRIBBuildable, thirdRIBBuilder: ThirdRIBBuildable) {
        self.secondRIBBuilder = secondRIBBuilder
        self.thirdRIBBuilder = thirdRIBBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToSecondRIB() {
        let secondRIBRouter = secondRIBBuilder.build(withListener: interactor)
        self.secondRIBRouter = secondRIBRouter
//        let secondRIBViewControllable = secondRIBRouter.viewControllable
        attachChild(secondRIBRouter)
//        viewController.uiviewController.navigationController?.pushViewController(secondRIBViewControllable.uiviewController, animated: true)
    }
    
    func routeAwayFromSecondRIB() {
        
    }
    
    func routeToThirdRIB() {
        let thirdRIBRouter = thirdRIBBuilder.build(withListener: interactor)
        self.thirdRIBRouter = thirdRIBRouter
        nonisolated(unsafe) let thirdRIBViewControllable = thirdRIBRouter.viewControllable
        attachChild(thirdRIBRouter)
        
        nonisolated(unsafe) let viewController = self.viewController
        Task { @MainActor in
            viewController.attachThirRIBViewController(thirdRIBViewControllable.uiviewController)
        }
//        viewController.attachThirRIBViewController(thirdRIBViewControllable)
//        viewController.uiviewController.navigationController?.pushViewController(thirdRIBViewControllable.uiviewController, animated: true)
    }
    
    func routeAwayFromThirdRIB() {
        print("routeAwayFromThirdRIB")
        if let thirdRIBRouter = thirdRIBRouter {
            self.thirdRIBRouter = nil
            nonisolated(unsafe) let viewController = self.viewController
            Task { @MainActor in
//                viewController.uiviewController.navigationController?.popToViewController(viewController.uiviewController, animated: true)
                viewController.uiviewController.dismiss(animated: true)
            }
            detachChild(thirdRIBRouter)
        }
    }
}
