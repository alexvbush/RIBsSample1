//
//  FirstRIBRouter.swift
//  RIBsSample1
//
//  Created by Alex Bush on 9/27/25.
//

import RIBs

protocol FirstRIBInteractable: Interactable, SecondRIBListener, ThirdRIBListener {
    var router: FirstRIBRouting? { get set }
    var listener: FirstRIBListener? { get set }
}

protocol FirstRIBViewControllable: ViewControllable, SecondRIBViewControllable {
    func attachThirRIBViewController(_ viewController: ViewControllable)
}

nonisolated final class FirstRIBRouter: ViewableRouter<FirstRIBInteractable, FirstRIBViewControllable>, FirstRIBRouting {
    
    private let secondRIBBuilder: SecondRIBBuildable
    private var secondRIBRouter: SecondRIBRouting?
    
    private let thirdRIBBuilder: ThirdRIBBuildable
    private var thirdRIBRouter: ThirdRIBRouting?

    init(interactor: FirstRIBInteractable, viewController: FirstRIBViewControllable,
         secondRIBBuilder: SecondRIBBuildable, thirdRIBBuilder: ThirdRIBBuildable) {
        self.secondRIBBuilder = secondRIBBuilder
        self.thirdRIBBuilder = thirdRIBBuilder
        super.init(interactor: interactor, viewController: viewController)
//        interactor.router = self
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
        let thirdRIBViewControllable = thirdRIBRouter.viewControllable
        attachChild(thirdRIBRouter)
//        viewController.attachThirRIBViewController(thirdRIBViewControllable)
//        viewController.uiviewController.navigationController?.pushViewController(thirdRIBViewControllable.uiviewController, animated: true)
    }
    
    func routeAwayFromThirdRIB() {
        
    }
}
