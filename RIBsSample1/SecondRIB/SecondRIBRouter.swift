//
//  SecondRIBRouter.swift
//  RIBsSample1
//
//  Created by Alex Bush on 9/27/25.
//

import RIBs

protocol SecondRIBInteractable: Interactable {
    nonisolated var router: SecondRIBRouting? { get set }
    var listener: SecondRIBListener? { get set }
}

protocol SecondRIBViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

nonisolated final class SecondRIBRouter: Router<SecondRIBInteractable>, SecondRIBRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SecondRIBInteractable, viewController: SecondRIBViewControllable) {
        self.viewController = viewController
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }

    // MARK: - Private

    private let viewController: SecondRIBViewControllable
}
