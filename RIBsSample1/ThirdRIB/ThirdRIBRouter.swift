//
//  ThirdRIBRouter.swift
//  RIBsSample1
//
//  Created by Alex Bush on 10/4/25.
//

import RIBs

protocol ThirdRIBInteractable: Interactable {
    nonisolated var router: ThirdRIBRouting? { get set }
    var listener: ThirdRIBListener? { get set }
}

protocol ThirdRIBViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

nonisolated final class ThirdRIBRouter: ViewableRouter<ThirdRIBInteractable, ThirdRIBViewControllable>, ThirdRIBRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ThirdRIBInteractable, viewController: ThirdRIBViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
