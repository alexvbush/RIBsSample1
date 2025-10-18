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

final class FirstRIBRouter: ViewableRouter<FirstRIBInteractable, FirstRIBViewControllable>, FirstRIBRouting, SendableMetatype, @unchecked Sendable {
    
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
//        let thirdRIBRouter = thirdRIBBuilder.build(withListener: interactor)
//        self.thirdRIBRouter = thirdRIBRouter
//        nonisolated(unsafe) let thirdRIBViewControllable = thirdRIBRouter.viewControllable
//        attachChild(thirdRIBRouter)
//        
//        nonisolated(unsafe) let viewController = self.viewController
//        Task { @MainActor in
//            viewController.attachThirRIBViewController(thirdRIBViewControllable.uiviewController)
//        }
//        viewController.attachThirRIBViewController(thirdRIBViewControllable)
//        viewController.uiviewController.navigationController?.pushViewController(thirdRIBViewControllable.uiviewController, animated: true)
        
        let thirdRIBRouter = thirdRIBBuilder.build(withListener: interactor)
        self.thirdRIBRouter = thirdRIBRouter
        navigateOnMainThread(with: thirdRIBRouter.viewControllable) { thisRouterViewController, childViewController in
            thisRouterViewController.attachThirRIBViewController(childViewController.uiviewController)
        }
        attachChild(thirdRIBRouter)
    }
    
    func routeAwayFromThirdRIB() {
        print("routeAwayFromThirdRIB")
//        if let thirdRIBRouter = thirdRIBRouter {
//            self.thirdRIBRouter = nil
//            nonisolated(unsafe) let viewController = self.viewController
////            nonisolated(unsafe) weak var self1 = self
//            nonisolated(unsafe) let thirdRIBRouter = thirdRIBRouter
//            Task { @MainActor in
////                viewController.uiviewController.navigationController?.popToViewController(viewController.uiviewController, animated: true)
//                viewController.uiviewController.dismiss(animated: true) {
//                    print("UI dismiss finished")
////                    self1.detachChild(thirdRIBRouter)
//                }
//            }
//            print("detach called")
//            detachChild(thirdRIBRouter)
//        }
        
//        if let thirdRIBRouter = thirdRIBRouter {
//            self.thirdRIBRouter = nil
//            
//            navigateOnMainThread1 { viewControllable in
//                viewControllable.uiviewController.dismiss(animated: true) { [weak self] in
//                    self?.detachChild(thirdRIBRouter)
//                }
//            }
//            
////            navigateOnMainThread { thisRouter, viewControllable in
//////                thisRouter.thirdRIBRouter = nil
////                viewControllable.uiviewController.dismiss(animated: true) {
//////                    if let thirdRouter1  = thisRouter.thirdRIBRouter {
//////                        
//////                    }
////                    self1.detachChild(thirdRIBRouter)
////                }
////            }
//            
////            Task { @MainActor in
////                viewController.uiviewController.dismiss(animated: true)
////            }
//            
////            viewController.uiviewController.dismiss(animated: true) {
////                self.detachChild(thirdRIBRouter)
////            }
//        }
        
//        if let thirdRIBRouter = thirdRIBRouter {
//            self.thirdRIBRouter = nil
//            viewControllable.uiviewController.dismiss(animated: true)
//            self?.detachChild(thirdRIBRouter)
//        }
//        
//        if let thirdRIBRouter = thirdRIBRouter {
//            self.thirdRIBRouter = nil
//            viewControllable.uiviewController.dismiss(animated: true) { [weak self] in
//                self?.detachChild(thirdRIBRouter)
//            }
//        }
        
        if let thirdRIBRouter = thirdRIBRouter {
            self.thirdRIBRouter = nil
            
            navigateOnMainThread { thisRouterViewController in
                thisRouterViewController.uiviewController.dismiss(animated: true) { [weak self] in
                    self?.detachChild(thirdRIBRouter)
                }
            }
        }
        
//        navigateOnMainThread(with: childRouter.viewControllable) { thisRouterViewController, childRouterViewController in
//            // do UI work here
//        }
//        
//        navigateOnMainThread(with: childRouter.viewControllable, secondChildRouter.viewControllable) { thisRouterViewController, childRouterViewController, secondChildRouterViewController in
//            // do UI work here
//        }
        
        print("routeAwayFromThirdRIB finished")
    }
}
